class AddIndexToLanguagesNameProfileId < ActiveRecord::Migration[7.0]
  def change
    add_index :languages, [:name, :profile_id], unique: true
  end
end
