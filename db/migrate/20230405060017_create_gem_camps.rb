class CreateGemCamps < ActiveRecord::Migration[7.0]
  def change
    create_table :gem_camps do |t|
      t.datetime :pre_class_date
      t.integer :letter_type, default: 0
      t.integer :signed_via, default: 0
      t.datetime :sent_at
      t.datetime :reply_at
      t.string :status
      t.text :notes
      t.references :applicant_batch_ship

      t.timestamps
    end
  end
end
