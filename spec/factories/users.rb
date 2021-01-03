FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role { :manager }

    association :community

    trait :with_phone do
      phone { Faker::PhoneNumber.cell_phone }
    end

    trait :like_tenant do
      role { :tenant }
    end

    trait :like_owner do
      role { :owner }
    end
  end
end
