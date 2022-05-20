class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.references :user
      t.string :uid
      t.string :name
      t.string :identifier
      t.text :token
      t.text :refresh
      t.datetime :expires_at

      t.timestamps
    end
  end
end
