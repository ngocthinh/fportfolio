FactoryGirl.define do
  factory :project do
    name{Faker::Book.title}
    url "https://github.com/fzaninotto/Faker#fakerproviderdatetime"
    core_features{Faker::Code.ean}
    realease_note "ABC"
    git_repository "https://github.com/stympy/faker"
    server_information "ABC"
    platform "Ruby"
    description{Faker::Lorem.sentence}
    category
    pm_url "ABC"
  end
end
