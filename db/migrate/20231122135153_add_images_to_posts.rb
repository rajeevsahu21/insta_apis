class AddImagesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :images, :text, array: true, default: []
  end
end
