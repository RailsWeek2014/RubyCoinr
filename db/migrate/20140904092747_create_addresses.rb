class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :addr
      t.references :wallet, index: true

      t.timestamps
    end
  end
end
