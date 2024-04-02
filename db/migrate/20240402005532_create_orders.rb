class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal :total
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
