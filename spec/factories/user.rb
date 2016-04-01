FactoryGirl.define do
  factory :user do
    username Faker::StarWars.character
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
