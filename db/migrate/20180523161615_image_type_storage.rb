class ImageTypeStorage < ActiveRecord::Migration[5.0]
  def change
    change_table :images do |t|
      t.string :container, :default => 'imgur'
    end
  end
end
