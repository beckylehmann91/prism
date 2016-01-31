class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string :filename
      t.integer :luminence
      t.integer :contrast
      t.integer :color_dominance # 1 - 3
      t.integer :color_variety # 1 - 10
      t.string  :role

      t.timestamps null: false
    end
  end
end
