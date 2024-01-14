class CreateExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :experiences do |t|
      t.string :company, null: false
      t.string :title, null: false
      t.string :location
      t.string :country, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :description
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
