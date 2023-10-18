class RenameConfirmPasswordToPasswordConfirmation < ActiveRecord::Migration[6.1]
  def up
    rename_column :users, :confirm_password, :password_confirmation
  end
  
  def down
    rename_column :users, :password_confirmation, :confirm_password
  end
  
end
