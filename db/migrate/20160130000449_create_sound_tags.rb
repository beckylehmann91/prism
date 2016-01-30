class CreateSoundTags < ActiveRecord::Migration
  def change
    create_table :sound_tags do |t|
      t.references :sound, index: true, foreign_key: true
      t.references :image, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
