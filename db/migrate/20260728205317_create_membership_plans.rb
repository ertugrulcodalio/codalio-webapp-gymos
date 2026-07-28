class CreateMembershipPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :membership_plans do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.string :status, null: false
      t.integer :weekly_class_limit
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
