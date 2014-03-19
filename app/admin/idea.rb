ActiveAdmin.register Idea do
  controller do
    def scoped_collection
      current_ideas
    end
  end
  
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

  permit_params :title, :content, :created_at, :updated_at

  filter :user
  filter :area
  filter :title
  filter :content
  filter :created_at
  filter :updated_at

  index do
    id_column
    column "User" do |idea|
      link_to idea.user.name, admin_user_path(idea.user.id)
    end
    column :title
    column "Challenge" do |idea|
      link_to idea.area.title, admin_challenge_path(idea.area.id)
    end
    column :created_at
    column :updated_at
    default_actions
  end
  
end
