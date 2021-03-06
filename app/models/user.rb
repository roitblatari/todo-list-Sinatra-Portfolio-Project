class User < ActiveRecord::Base
  has_secure_password
  has_many :todos
  validates :username, presence: true
  validates :email, presence: true
    

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
   self.all.find{|user| slug == user.slug} 
  end

end
