class WechatReplyRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  field :keyword, type: String
  field :event, type: String
  field :origin
end
