class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews do |t|
      t.integer :status, default: 0
      t.string :remarks
      t.datetime :interview_date
      t.references :applicant_batch_ship

      t.timestamps
    end

    add_reference :call_logs, :interview, foreign_key: true
  end
end
