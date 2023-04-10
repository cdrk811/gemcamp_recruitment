class ChangeSourcingChannelToArrayInApplicationBatchShip < ActiveRecord::Migration[7.0]
  def change
    change_column :applicant_batch_ships, :sourcing_channel, :string, array: true, default: '[]'
  end
end
