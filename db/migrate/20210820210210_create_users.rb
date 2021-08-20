class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :email
      t.text :token
      t.text :refresh
      t.datetime :expires_at

      t.timestamps
    end
  end
end
