class CreateEducationHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :education_histories do |t|
      t.string :school, null: false
      t.string :degree
      t.string :study_field
      t.date :from
      t.date :to
      t.text :description
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
