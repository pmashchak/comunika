FactoryBot.define do
  factory :community do
    name { Faker::Company.name }
    subdomain { Faker::Internet.domain_name }
  end
end
