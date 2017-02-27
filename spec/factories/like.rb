FactoryGirl.define do
  factory :like do
    target_id 1
    target_type "Project"
    user
    project
  end
end