FactoryBot.define do
  factory :message do
    text { Faker::Lorem.word }
    association :user

    trait :with_sid do
      sid { Faker::Alphanumeric.alpha(number: 20) }
    end

    trait :queued do
      state { :queued }
    end

    trait :delivered do
      state { :delivered }
    end

    trait :error do
      state { :error }
    end
  end
end
