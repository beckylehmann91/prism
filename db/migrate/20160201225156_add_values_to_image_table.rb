class AddValuesToImageTable < ActiveRecord::Migration
  def change
    add_column :images, :lum, :integer
    add_column :images, :con, :integer
    add_column :images, :var, :integer
    add_column :images, :color_dom, :integer

  end
end
