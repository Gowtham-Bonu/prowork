class RemoveTeamSizeFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :team_size, :integer
  end
end
