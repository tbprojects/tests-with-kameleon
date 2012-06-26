FactoryGirl.define do
  factory :user do
    email 'some.user@example.com'
    password 'secret'
  end

  factory :project do
    active true
  end
end