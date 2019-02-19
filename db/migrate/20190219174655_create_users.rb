class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.belongs_to :community, foreign_key: true
      t.string :name
      t.string :email
      t.string :role

      t.timestamps
    end
  end
end
