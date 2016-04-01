FactoryGirl.define do
  factory :wiki do
    title Faker::Hipster.sentence(4)
    body Faker::Hipster.paragraph(5)
    private false
    user
  end
end
