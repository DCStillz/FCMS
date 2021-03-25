class DeleteType < ActiveRecord::Migration[5.2]
    def change
      remove_column(:movies, :type)
    end
  end
  