class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :title
      t.string :link
      t.integer :category_id
      t.integer :user_id

    end
  end
end
