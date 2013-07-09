require "open-uri"
class User < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  
  acts_as_authentic do |config|
    config.login_field = :username
  end
  
  has_attached_file :image, :styles => {:small => "150x150#"}
end
