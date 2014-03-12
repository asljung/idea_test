ActiveAdmin.register User do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  permit_params :name, :email, :password, :password_confirmation, :active, :admin
  filter :active
  filter :name
  filter :email
  filter :admin
  filter :created_at 
  filter :updated_at

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :active
      f.input :admin
    end
    f.actions
  end

  index do
    id_column
    column :active
    column :name
    column :email
    column :admin
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :active
      row :name
      row :email
      row :admin
      row :created_at
      row :updated_at
    end
  end
end
