FactoryGirl.define do
  factory :comment do
    sequence(:content){|n| "评论内容#{n}"}
    association :commentable, factory: :article
    user
  end
end

