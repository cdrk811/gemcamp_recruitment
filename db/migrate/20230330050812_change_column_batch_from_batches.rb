class ChangeColumnBatchFromBatches < ActiveRecord::Migration[7.0]
  def change
    remove_column :batches, :batch, :string
    add_column :batches, :number, :string
  end
end
