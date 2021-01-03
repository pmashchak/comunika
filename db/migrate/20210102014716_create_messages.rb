class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :sid
      t.string :state
      t.references :user
      t.timestamps
    end
  end
end
