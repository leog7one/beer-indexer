class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :abv
      t.text :description
      t.string :style

      t.timestamps null: false
    end
  end
end
