class AddColumnListingsVerification < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :verification, :integer, :default => 0
  end
end
