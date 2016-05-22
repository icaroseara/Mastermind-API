FactoryGirl.define do
  factory :game do
    association :players, factory: :player
    association :guesses, factory: :guess
  end
end