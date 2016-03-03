class CreateLzs < ActiveRecord::Migration
  def change
    create_table :lzs do |t|

      t.timestamps
    end
  end
end
