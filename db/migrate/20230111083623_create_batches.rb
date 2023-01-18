class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.string :batch
      t.integer :status
      t.timestamps
    end

    create_table :batch_applicants do |t|
      t.bigint :batch_id
      t.bigint :applicant_id
      t.string :status
      t.string :remarks
      t.timestamps
    end

    create_table :call_logs do |t|
      t.bigint :batch_applicant_id
      t.datetime :interview_date
      t.string :remarks
      t.timestamps
    end

    add_index :batch_applicants, [:batch_id, :applicant_id], unique: true
    add_index :call_logs, :batch_applicant_id
    add_foreign_key :batch_applicants, :batches, column: :batch_id
    add_foreign_key :batch_applicants, :applicants, column: :applicant_id
  end
end
