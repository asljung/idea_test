ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do

      column do
        panel "Recent ideas" do
          table_for current_ideas.order("created_at desc").limit(5) do
            column :title do |idea|
              link_to idea.title, [:admin, idea]
            end
            column "Challenge" do |idea|
              link_to idea.area.title, admin_challenge_path(idea.area.id)
            end
            column "User" do |idea|
              link_to idea.user.name, admin_user_path(idea.user.id)
            end
            column "Creation date" do |idea| 
              idea.created_at.to_formatted_s(:short)
            end
          end
          strong { link_to "View All Ideas", admin_ideas_path }
        end
      end

      column do
        panel "Recent comments" do
          table_for current_comments.order("created_at desc").limit(5) do
            column "Comment" do |comment|
              link_to comment.body.truncate(100), [:admin, comment]
            end
            column "User" do |comment|
              link_to comment.user.name, admin_user_path(comment.user.id)
            end
            column "Creation date" do |comment| 
              comment.created_at.to_formatted_s(:short)
            end
          end
          strong { link_to "View All Comments", admin_comments_path }
        end
      end

    end # columns

    columns do
      column do
        panel "New user not activated" do
          table_for current_org.users.not_active.order("created_at desc").limit(10) do
            column :name do |user|
              link_to user.name, [:admin, user]
            end
            column "Created" do |user|
              user.created_at.to_formatted_s(:short)
            end
            column "Actions" do |user|
              link_to "Edit", edit_admin_user_path(user.id)
            end
          end
          strong { link_to "View All Users", admin_users_path }
        end
      end

      column do
        panel "Challenges" do
          table_for current_areas.order("created_at desc") do
            column :title do |area|
              link_to area.title, admin_challenge_path(area.id)
            end
            column "Number of Ideas" do |area|
              link_to area.ideas.count, admin_ideas_path(:utf8 => "✓", :q => {:area_id_eq => area.id}, :area_id => area.id, :commit => "Filter")
            end
          end
          strong { link_to "View All Challenges", admin_challenges_path }
        end
      end

    end # columns

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
