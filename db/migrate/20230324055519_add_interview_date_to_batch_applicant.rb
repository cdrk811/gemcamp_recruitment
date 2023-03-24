class AddInterviewDateToBatchApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :batch_applicants, :interview_date, :datetime
  end
end
