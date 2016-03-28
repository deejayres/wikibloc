FactoryGirl.define do
  factory :user do
    username Faker::StarWars.character
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end

  factory :wiki do
    title Faker::Hipster.sentence(4)
    body Faker::Hipster.paragraph(5)
    private false
    user
  end
end
