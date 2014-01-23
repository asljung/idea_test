namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_ideas
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_ideas
  users = User.all(limit: 6)
  50.times do
    title = Faker::Lorem.sentence(1)
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.ideas.create!(title: title, content: content) }
  end
end