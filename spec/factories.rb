FactoryGirl.define do
  factory :organisation do
    name "Name"
    description "Lorem ipsum"
    area_description "Lorem ipsum"
  end

  factory :user do
    organisation
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :idea do
    title "Title"
    content "Lorem ipsum"
    area
    user
  end

  factory :comment do
    title "Title"
    body "Lorem ipsum"
    user
    commentable
  end

  factory :commentable, :class => "Idea" do
    title "Title"
    content "Lorem ipsum"
    area
    user
  end

  factory :area do
    organisation
    title "Title"
    description "Lorem ipsum"
  end

end