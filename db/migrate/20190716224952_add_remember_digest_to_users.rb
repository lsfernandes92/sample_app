class AddRememberDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_disgest, :string
  end
end
