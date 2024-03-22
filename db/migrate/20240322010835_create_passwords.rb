class CreatePasswords < ActiveRecord::Migration[7.1]
  def change
    create_table :passwords do |t|
      t.references :user, null: false, foreign_key: true
      t.string :resourse_name
      t.string :login
      t.string :password_encrypted

      t.timestamps
    end
  end
end
