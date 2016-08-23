class AddIndexToUsersFacebookId < ActiveRecord::Migration[5.0]
  def change
      add_index :users, :facebook_id, unique: true
  end
end
