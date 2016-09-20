class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, type: String
  field :uid, type: String
  field :uname, type: String
  field :access_token, type: String
  field :omniauth

  belongs_to :user, index: true

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.create_from_hash(hash, user)
    Authentication.create(user: user, uid: hash['uid'], provider: hash['provider'], uname: hash['info']['nickname'], access_token: (hash['credentials'] ? hash['credentials']['token'] : nil), omniauth: hash.to_hash)
  end
end

