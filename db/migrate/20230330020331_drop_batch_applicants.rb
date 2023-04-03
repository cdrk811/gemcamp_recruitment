class DropBatchApplicants < ActiveRecord::Migration[7.0]
  def change
    remove_column :call_logs, :batch_applicant_id, :bigint
    drop_table :batch_applicants, force: :cascade
  end
end
