require "date"

FactoryGirl.define do
  factory :message do
    body          "sample message"
    image           { Rack::Test::UploadedFile.new('spec/test.jpg', 'image/jpg') }
  end
end
