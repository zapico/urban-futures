class CreateArticles < ActiveRecord::Migration
  def self.up
     create_table :articles do |t|
      t.column :name, :string
      t.column :content, :text
      t.column :city_id, :integer
      t.column :lng, :float, { :precision => 30, :scale => 20 }
      t.column :lat, :float, { :precision => 30, :scale => 20 }
      t.timestamps
      end
  end

  def self.down
      drop_table :articles
  end
end
