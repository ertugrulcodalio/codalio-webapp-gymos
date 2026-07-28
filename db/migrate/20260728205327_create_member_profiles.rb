class CreateMemberProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :member_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false
      t.references :organization, null: false, foreign_key: true
      t.references :membership_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
