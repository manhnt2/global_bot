class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.references :programmable, polymorphic: true, index: true
      t.integer :program_type
      t.integer :unipos_share_number, default: 10

      t.timestamps
    end
  end
end
