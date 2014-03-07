class AddSubdomainToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :subdomain, :string
  end
end
