class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :job_id
      t.integer :successor_id

      t.timestamps
    end
  end
end
