class CreateCostHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :cost_histories do |t|
      t.references :coin, null: false, foreign_key: true
      t.float :amount, null: false
      t.float :difficulty, null: false

      t.timestamps
    end
  end
end
