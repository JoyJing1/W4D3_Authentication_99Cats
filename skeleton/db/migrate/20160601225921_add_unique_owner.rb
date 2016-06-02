class AddUniqueOwner < ActiveRecord::Migration
  def change
    change_column :cats, :user_id, :integer, null: false
  end
end
