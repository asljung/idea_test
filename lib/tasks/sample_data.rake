namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_organisations
    make_users
    make_areas
    make_ideas
    make_comments
    make_votes
  end
end

def make_organisation
  2.times do |n|
    name = Faker::Lorem.words(2)
    description = Faker::Lorem.sentence(5)
    area_description = Faker::Lorem.sentence(5)
    Organisation.create!(name: name, description: description, area_description: area_description, subdomain: "test#{n}")
  end
end

def make_users
  orgs = Organisation.all
  orgs.each { |org|
    admin = User.create!(name:     "Example User",
                         email:    "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true,
                         active: true,
                         organisation_id: org.id)
    30.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name:     name,
                   email:    email,
                   password: password,
                   password_confirmation: password,
                   admin: false,
                   active: true,
                   organisation_id: org.id)
    end
  }
end

def make_areas
  orgs = Organisation.all
  orgs.each { |org|
    5.times do
      title = Faker::Lorem.sentence(rand(2..4)).chomp('.')
      description = Faker::Lorem.sentences(rand(1..4)).join(" ")
      Area.create!(title: title, description: description, organisation_id: org.id)
    end
  }
end

def make_ideas
  orgs = Organisation.all
  orgs.each { |org|
    users = org.users.limit(10)
    areas = org.areas
    areas.each { |area|
      users.each { |user|
      title = Faker::Lorem.sentence(rand(2..4)).chomp('.')
      content = "<p>" + Faker::Lorem.paragraphs(rand(2..8)).join('</p><p>') + "</p>"
      vote_count = 0
      comment_count = 0
      area_id = area.id
      user.ideas.create!(title: title, content: content, area_id: area_id) }
    }
  }
end

def make_comments
  orgs = Organisation.all
  orgs.each { |org|
    users = org.users.limit(10)
    ideas = Idea.joins(area: :organisation).where(organisations: {id: org.id})
    ideas.each { |idea|   
      users.each { |user| 
        body = Faker::Lorem.sentences(rand(1..4)).join(" ")
        commentable_id = idea.id
        Comment.create(body: body, commentable_id: commentable_id, commentable_type: "Idea", user_id: user.id)
        idea.increment!(:comment_count) 
      }
    }
  }
end

def make_votes
  orgs = Organisation.all
  orgs.each { |org|
    users = org.users.limit(6)
    ideas = Idea.all
    users.each { |user|
      ideas.each{ |idea|
        user.vote!(idea)
      }
    }
  }
end

