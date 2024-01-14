class AddPolicyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :policy, :boolean, null: false
  end
end
