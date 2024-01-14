class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, index: true
      t.string :months, array: true
      t.string :experience
      t.string :hourly_rate, array: true
      t.decimal :project_budget
      t.text :description
      t.integer :status
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
