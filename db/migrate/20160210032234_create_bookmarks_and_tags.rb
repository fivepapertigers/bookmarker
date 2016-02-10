class CreateBookmarksAndTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :user
      t.string :label
      t.timestamps null: false
    end
 
    create_table :bookmarks do |t|
      t.belongs_to :user
      t.string :name
      t.string :path
      t.timestamps null: false
    end
 
    create_table :bookmarks_tags, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :bookmark, index: true
    end
  end
end