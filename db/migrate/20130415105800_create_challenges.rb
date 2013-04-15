class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :content
      t.date :begin
      t.date :end
      t.string :reward
      t.integer :user_id

      t.timestamps
    end
    add_index :challenges, [:user_id, :created_at]
  end
end
