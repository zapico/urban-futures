class CreateCities < ActiveRecord::Migration
  def self.up
     create_table :cities do |t|
      t.column :name, :string
      t.column :lng, :float, { :precision => 30, :scale => 20 }
      t.column :lat, :float, { :precision => 30, :scale => 20 }
      t.timestamps
      end
  end

  def self.down
      drop_table :cities
  end
end
