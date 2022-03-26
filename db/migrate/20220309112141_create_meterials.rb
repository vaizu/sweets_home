class CreateMeterials < ActiveRecord::Migration[6.1]
  def change
    create_table :meterials do |t|
      t.integer :post_id
      t.string :meterial_name
      t.string :quantity

      t.timestamps
    end
  end
end
