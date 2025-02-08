class CreateBillboards < ActiveRecord::Migration[8.0]
  def change
    create_table :billboards do |t|
      t.string :address
      t.string :image
      t.integer :votes

      t.timestamps
    end
  end
end
