class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
 	  t.references :user, index: true
      t.string :label
      t.string :password
      t.string :pubkey
      t.string :privkey

      t.timestamps
    end
  end
end
