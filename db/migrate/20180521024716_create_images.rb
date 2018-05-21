class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :external_id
      t.string :name
      t.string :description
      t.integer :album_id
      t.string :link
      t.integer :width
      t.integer :height
      t.integer :size
      t.string :type

      t.timestamps
    end
  end
end
