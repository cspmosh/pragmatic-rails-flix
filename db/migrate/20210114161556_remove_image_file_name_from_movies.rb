class RemoveImageFileNameFromMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :file_image_name, :string
  end
end
