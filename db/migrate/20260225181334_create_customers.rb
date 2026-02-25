class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.string :contact_name
      t.string :email
      t.string :phone
      t.text :needs
      t.text :notes
      t.integer :status

      t.timestamps
    end
  end
end
