class CreateFilas < ActiveRecord::Migration
  def change
    create_table :filas do |t|

      t.timestamps
    end
  end
end
