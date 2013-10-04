class Movie < ActiveRecord::Base
  attr_accessible :language, :name, :release_date, :movie

  mount_uploader :movie, MovieUploader # uploader class
end
