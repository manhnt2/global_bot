class CreateProgramParams < ActiveRecord::Migration[5.1]
  def change
    create_table :program_params do |t|
      t.references :program_parammable, polymorphic: true, index: { name: 'index_program_parammable' }
      t.references :program, foreign_key: true
      t.integer :status, default: ProgramParam.statuses['error']
      t.text :unipos_request
      t.string :unipos_user_id
      t.integer :unipos_received_number, default: 0
      t.timestamps
    end
  end
end
