class CreateCertifications < ActiveRecord::Migration[7.0]
  def change
    create_table :certifications do |t|
      t.date :issue_date, null: false
      t.string :name, null: false
      t.date :expiration_date
      t.string :cert_id
      t.string :certification_url
      t.belongs_to :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
