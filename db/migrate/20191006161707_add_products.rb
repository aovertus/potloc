class AddProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :store
      t.string :model
      t.integer :quantity
      t.timestamps
    end
  end
end
