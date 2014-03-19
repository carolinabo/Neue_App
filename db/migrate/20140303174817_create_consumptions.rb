class CreateConsumptions < ActiveRecord::Migration
  def change
    create_table :consumptions do |t|
      t.integer :job_id
      t.integer :resource_id
      t.integer :consumption

      t.timestamps
    end
  end
end
