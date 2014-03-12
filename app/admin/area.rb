ActiveAdmin.register Area, as: "Challenge" do

  
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
  filter :title
  filter :description
  filter :created_at
  filter :updated_at

  permit_params :title, :description, :thumbnail, :_destroy

  form do |f|
    f.inputs "Challenge Details" do
      f.input :title
      f.input :description
      f.input :thumbnail, :as => :file, :hint => f.template.image_tag(f.object.thumbnail.url(:thumb))
      # Will preview the image when the object is edited
      f.input :_destroy, as: :boolean, required: :false, label: 'Remove image'
    end
    f.actions
  end

  index do
    id_column
    column "Thumbnail" do |area|
      image_tag(area.thumbnail.url(:thumb))
    end
    column :title
    column :description
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row "Thumbnail" do |area|
        image_tag(area.thumbnail.url(:thumb))
      end
      row :title
      row :description
      row :created_at
      row :updated_at
    end
  end

  
end
