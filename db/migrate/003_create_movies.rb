class CreateMovies < ActiveRecord::Migration[5.2]
	def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.integer :rotten_tomatoes_critic_score
      t.integer :rotten_tomatoes_audience_score
      t.integer :box_office_actual
      t.integer :box_office_adjusted
    end
  end
end
