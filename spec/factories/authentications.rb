FactoryGirl.define do
  factory :authentication do
    provider "MyString"
    sequence(:uid){|n| "uid:#{n}"}
    sequence(:uname){|n| "uname:#{n}"}
    sequence(:access_token){|n| "access_token:#{n}"}
    omniauth "MyString"
    user_id 1
    #factory :test_wechat_id_authentication do
      #provider "wechat"
      #uid ENV['WECHAT_OPENID']
    #end
  end
end
