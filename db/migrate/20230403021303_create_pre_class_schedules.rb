class CreatePreClassSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :pre_class_schedules do |t|
      t.datetime :sent_at
      t.datetime :reply_at
      t.datetime :date
      t.string :status
      t.text :notes
      t.references :applicant_batch_ship

      t.timestamps
    end
  end
end
