class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true
  validates :commentable, presence: true
  validates :user, presence: true

  scope :recent, ->{order(id: :desc)}
end
