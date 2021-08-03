class AddWeatherToPosts < ActiveRecord::Migration[6.0]
  def change

    add_column :posts, :weather, :float

  end
end
