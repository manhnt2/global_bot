class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name

      t.references :project, foreign_key: true
      t.string :slug, index: true

      t.timestamps
    end
  end
end
