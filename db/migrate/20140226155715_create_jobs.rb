class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :duration
      t.integer :fez
      t.integer :sez
      t.integer :begin
      t.integer :end
      t.timestamps
    end
  end
end
