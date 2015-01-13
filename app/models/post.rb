class Post < ActiveRecord::Base
  # Belongs to Topic
  belongs_to :topic, inverse_of: :posts

  # Belongs to User
  belongs_to :user,  inverse_of: :posts

  # Self joins
  has_many    :sub_posts,    class_name: 'Post', foreign_key: 'parent_id', inverse_of: :parent_post
  belongs_to  :parent_post,  class_name: 'Post', foreign_key: 'parent_id', inverse_of: :sub_posts

  # chattable
  has_many    :messages, inverse_of: :chattable, as: :chattable

  # events
  has_many    :events, inverse_of: :post, dependent: :delete_all
  has_many    :events_as_sub, inverse_of: :post,class_name: :Event, foreign_key: :sub_post_id, dependent: :delete_all

  # Shortcut for Markdown parsed introduction

  def content_parsed
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    .render(self.content || "")
  end

  def content_plain
    Sanitize.clean(self.content_parsed, Sanitize::Config::STRICT)
  end
end
