class CreateJiveAddOns < ActiveRecord::Migration
	def change
		create_table :jive_add_ons do |t|
			t.string :name
			t.string :tenant_id
			t.string :client_id
			t.string :client_secret
			t.string :jive_signature
			t.string :jive_signature_url
			t.string :jive_url
			t.boolean :uninstalled
			t.integer :attempt

			t.timestamps null: false
		end
	end
end
