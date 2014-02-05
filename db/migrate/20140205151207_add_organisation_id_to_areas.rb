class AddOrganisationIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :organisation_id, :integer
    add_index :areas, :organisation_id
  end
end
