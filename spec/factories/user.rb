FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    password_confirmation "12345678"
    user_name {Faker::Name.name}
    email "user@gmail.com"
    password "12345678"
    phone "0128439239"
  end
end
