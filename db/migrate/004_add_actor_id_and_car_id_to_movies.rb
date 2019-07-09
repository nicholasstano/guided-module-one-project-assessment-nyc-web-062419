class AddActorIdAndCarIdToMovies < ActiveRecord::Migration[5.2]
  def change
  	  add_column :movies, :actor_id, :integer
  	  add_column :movies, :car_id, :integer
  end
end
