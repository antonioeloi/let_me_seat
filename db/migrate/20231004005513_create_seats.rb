class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.integer :row
      t.integer :column
      t.string :state
      t.integer :cost
      t.belongs_to :cart, null: true, foreign_key: true

      t.timestamps
    end
  end
end
