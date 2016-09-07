FactoryGirl.define do
  factory :article do
    sequence(:title){|n| "文章#{n}"}
    sequence(:content){|n| "文章内容#{n}"}
  end

end
