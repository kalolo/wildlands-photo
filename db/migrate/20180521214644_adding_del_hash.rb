class AddingDelHash < ActiveRecord::Migration[5.0]
  def change
    change_table :images do |t|
      t.string :deletehash, :default => ''
    end
  end
end
