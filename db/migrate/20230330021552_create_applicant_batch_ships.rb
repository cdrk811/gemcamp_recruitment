class CreateApplicantBatchShips < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_batch_ships do |t|
      t.datetime :application_date
      t.string :sourcing_channel
      t.string :resume_link
      t.references :applicant
      t.references :batch

      t.timestamps
    end
  end
end
