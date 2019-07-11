class AddOriginalDbFlagToActorsCarsMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :actors, :original_db, :boolean
    add_column :cars, :original_db, :boolean
    add_column :movies, :original_db, :boolean
  end
end
