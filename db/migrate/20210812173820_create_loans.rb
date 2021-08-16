class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.float :pmt
      t.float :value
      t.float :rate
      t.integer :months

      t.timestamps
    end
  end
end
