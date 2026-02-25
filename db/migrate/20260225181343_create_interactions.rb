class CreateInteractions < ActiveRecord::Migration[7.2]
  def change
    create_table :interactions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :contact_type
      t.text :summary
      t.text :action_taken
      t.date :due_date
      t.datetime :contacted_at

      t.timestamps
    end
  end
end
