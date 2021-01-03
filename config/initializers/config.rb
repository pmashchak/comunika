require "yaml"

module Comunika
  class SecureOrderedOptions < ActiveSupport::OrderedOptions
    def method_missing(name, *args)
      name_string = +name.to_s
      if name_string.chomp!("=")
        self[name_string] = args.first
      else
        bangs = name_string.chomp!("!")

        if bangs
          self[name_string].presence || raise(KeyError.new(":#{name_string} is blank"))
        else
          self[name_string]
        end
      end
    end
  end

  def self.config
    begin
      config = SecureOrderedOptions.new
      file_name = file_path
      if File.exist?(file_name)
        hash = YAML.load(File.read(file_name))
        keys_hash = (hash["default"] || {}).merge(hash[Rails.env] || {})
        keys_hash.each_pair do |key, value|
          config[key] = value
        end
      else
        raise 'Missing config.yml!'
      end
      config.default_proc = lambda do |hsh, k|
        raise "Key #{k.inspect} not found in config.yml file."
      end
      config
    end
  end

  def self.app_root
    File.expand_path(File.join(File.dirname(__FILE__), "../.."))
  end

  def self.file_path
    "#{app_root}/config/config.yml"
  end
end
