class Article
  KC_WARE_REGEXP = /Ware$/

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  belongs_to :articleable, polymorphic: true

  attr_accessor :ware_id

  validates :title, presence: true
  validates :content, presence: true

  scope :recent, ->{ order(id: :desc)}

  def articleable_is_ware?
    !!KC_WARE_REGEXP.match(articleable_type)
  end

  protected
  before_save :ware_id_to_articleable
  def ware_id_to_articleable
    if ware_id and ((articleable_type.nil? or articleable_is_ware?) and ware_id.to_s != articleable_id.to_s)
      self.articleable = KcCourses::Ware.find ware_id
    end
  end
end
