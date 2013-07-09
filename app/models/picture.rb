class Picture < ActiveRecord::Base
  belongs_to :user
  attr_accessor :image_url
  has_attached_file :image, :styles => {:small => "100x100#",:medium => "200x200#",:big => "300x300#"}

  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  before_validation :download_remote_image, :if => :image_url_provided?

  private
  def image_url_provided?
    !self.image_url.blank?
  end

  def download_remote_image
    require 'debugger';debugger
    self.image = do_download_remote_image
    self.remote_url = self.image_url
    self.image_url = nil
  end

  def do_download_remote_image
    begin
      io = open(URI.parse(self.image_url))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue => error# catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
      logger.error error.msg
    end
  end
end
