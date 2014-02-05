namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_organisation
    make_users
    make_areas
    make_ideas
    make_comments
  end
end

def make_organisation
  name = Faker::Lorem.sentence(1)
  description = Faker::Lorem.sentence(5)
  area_description = Faker::Lorem.sentence(5)
  Organisation.create!(name: name, description: description, area_description: area_description)
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true,
                       organisation_id: 1)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 organisation_id: 1)
  end
end

def make_areas
  5.times do
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(5)
    Area.create!(title: title, description: description, organisation_id: 1)
  end
end

def make_ideas
  users = User.all(limit: 6)
  areas = Area.all
  areas.each { |area|
    5.times do
      title = Faker::Lorem.sentence(1)
      content = Faker::Lorem.sentence(50)
      area_id = area.id
      users.each { |user| user.ideas.create!(title: title, content: content, area_id: area_id) }
    end
  }
end

def make_comments
  users = User.all(limit: 6)
  ideas = Idea.all
  ideas.each { |idea|
    5.times do
      title = Faker::Lorem.sentence(1)
      body = Faker::Lorem.sentence(20)
      commentable_id = idea.id
      users.each { |user| 
        Comment.create!(title: title, body: body, commentable_id: commentable_id, commentable_type: "Idea", user_id: user.id) }
    end
  }
end

