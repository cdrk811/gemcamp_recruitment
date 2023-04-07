class CreatePreClassResults < ActiveRecord::Migration[7.0]
  def change
    create_table :pre_class_results do |t|
      t.datetime :date_attended
      t.string :repository
      t.text :remarks
      t.string :result
      t.text :proctor_note
      t.string :commute_duration
      t.references :applicant_batch_ship

      t.timestamps
    end
  end
end
