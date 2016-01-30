class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string :filename
      t.timestamps null: false
      t.integer :luminence
    end
  end
end
