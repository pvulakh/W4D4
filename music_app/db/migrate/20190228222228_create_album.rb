class CreateAlbum < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false 
      t.integer :band_id, null: false 
      t.integer :year, null: false 
      t.string :live, default: false, null: false
    end
  end
end
