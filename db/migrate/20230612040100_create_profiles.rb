class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :professional_role, null: false
      t.text :bio, null: false
      t.decimal :hourly_rate, null: false
      t.string :postal_code
      t.string :phone, null: false
      t.string :country, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
