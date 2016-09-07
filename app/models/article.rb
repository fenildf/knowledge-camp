class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  belongs_to :articleable, polymorphic: true

  validates :title, presence: true
  validates :content, presence: true
end
