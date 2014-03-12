ActiveAdmin.register Comment do

  
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
  filter :body
  filter :created_at
  filter :updated_at

  index do
    id_column
    column "User" do |comment|
        link_to comment.user.name, admin_user_path(comment.user.id)
    end
    column :body
    column "Idea" do |comment|
        link_to comment.commentable.title, admin_idea_path(comment.commentable_id)
    end
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row "User" do |comment|
        link_to comment.user.name, admin_user_path(comment.user.id)
      end
      row :body
      row :created_at
      row :updated_at
    end
  end
  
end
