class DeleteBoxOfficeAdjustedColumnFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :box_office_adjusted, :integer
  end
end
