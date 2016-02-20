class CreateNos < ActiveRecord::Migration
  def change
    create_table :nos do |t|

      t.timestamps
    end
  end
end
