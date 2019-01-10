class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|
      t.integer :page_id
      t.integer :tag_id
    end
  end
end
