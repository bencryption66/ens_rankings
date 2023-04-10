class CreateNames < ActiveRecord::Migration[7.0]
  def change
    create_table :names do |t|
      t.string :name
      t.date :expiry_date
      t.integer :views
      t.string :token_id
      t.json :listings
      t.json :bids
      t.json :trades

      t.timestamps
    end
  end
end
