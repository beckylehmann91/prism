class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string :filename
      t.integer :luminence
      t.integer :contrast
      t.integer :color
      t.string  :role

      t.timestamps null: false
    end
  end
end
