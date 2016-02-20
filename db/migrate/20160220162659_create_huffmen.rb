class CreateHuffmen < ActiveRecord::Migration
  def change
    create_table :huffmen do |t|

      t.timestamps
    end
  end
end
