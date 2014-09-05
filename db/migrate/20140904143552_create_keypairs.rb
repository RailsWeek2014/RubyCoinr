class CreateKeypairs < ActiveRecord::Migration
  def change
    create_table :keypairs do |t|
      t.string :privkey
      t.string :pubkey
      t.string :address
      t.boolean :used
      t.references :wallet, index: true
      t.string :addr_qrcode_svg

      t.timestamps
    end
  end
end
