class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :name
      t.string :snack
      t.timestamps null: false
    end
  end
end
