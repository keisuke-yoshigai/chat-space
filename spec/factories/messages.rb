FactoryGirl.define do
  factory :message do
    body          "sample message"
    image           { Rack::Test::UploadedFile.new('spec/test.jpg', 'image/jpg') }

    factory :invalid_message do
      body        nil
      image        nil
    end

    factory :group_messages, class: :message do
      association :group, factory: :group
      association :user, factory: :user
    end
  end
end
