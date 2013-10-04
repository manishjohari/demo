class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :language
      t.string :movie
      t.date :release_date

      t.timestamps
    end
  end
end
