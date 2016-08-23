class AddAuthExpiresAtToUsers < ActiveRecord::Migration[5.0]
  def change
		add_column :users, :auth_expires_at, :datetime
  end
end
