require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class Post < ActiveRecord::Base
  has_many :posts
  has_many :post_tags
  has_many :tags, through: :post_tags
end

class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag
end

class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags
end
