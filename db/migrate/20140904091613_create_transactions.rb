class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :sender_addr
      t.string :status_msg
      t.boolean :confirmed
      t.string :receiver_addr
      t.string :amount
      t.string :fee
      t.string :label

      t.references :wallet, index: true

      t.timestamps
    end
  end
end
