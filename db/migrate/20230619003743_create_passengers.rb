class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    enable_extension("citext") unless extension_enabled?("citext")

    create_table :passengers do |t|
      t.text :name
      t.citext :email

      t.timestamps
    end
  end
end
