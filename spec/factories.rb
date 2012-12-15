FactoryGirl.define do
  factory :user do
    name "BadTyper Jim"
    email "goto@example.net"
    password "gotnotimetotype"
    password_confirmation "gotnotimetotype"
  end
end
