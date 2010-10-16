require 'paperclip'

class GiftEvent
  include MongoMapper::Document

  key :gift_admin_email, String, :required => true, :format => RFC822::EmailAddress
  key :gift_admin_token, String, :required => true, :unique => true
  key :access_token, String, :required => true, :unique => true
  key :gift_admin_name, String
  key :gift_title, String, :required => true
  key :gift_name, String, :required => true
  key :gift_price, Float, :required => true
  key :gift_link, String
  key :gift_file_path, String
  # image crap
  key :image_file_name, String
  key :image_content_type, String
  key :image_file_size, Integer
  key :image_updated_at, DateTime
  timestamps!
  
  before_validation :create_access_tokens
  many :contributions

  has_attached_file :image, :styles => { :medium => "600x600>", :thumb => "200x200>" }

  private
  
  def create_access_tokens
    if self.gift_admin_token.blank?
      self.gift_admin_token = ActiveSupport::SecureRandom.hex(16)
    end
    if self.access_token.blank?
      self.access_token = ActiveSupport::SecureRandom.hex(16)
    end
  end
end