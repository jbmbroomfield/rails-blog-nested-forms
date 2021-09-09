class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, :through => :post_tags

  accepts_nested_attributes_for :tags

  validates_presence_of :name, :content

  def tags_attributes=(tags_attributes)
    if tags_attributes.is_a?(Array) && tags_attributes.length > 0
      tags_attributes = tags_attributes[0]
    end
    tag_name = tags_attributes["name"]
    if tag_name && tag_name != ""
      tag = Tag.find_or_create_by(name: tag_name)
      self.tags << tag
    end
  end

end
