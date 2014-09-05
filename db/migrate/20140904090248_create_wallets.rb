class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
 	  t.references :user, index: true
      t.string :label
      t.integer :keypair_ptr_id

      t.timestamps
    end
  end
end
