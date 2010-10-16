class GiftEvent
  require 'carrierwave/orm/mongomapper'
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
  key :gift_event_image, String
  timestamps!
  
  before_validation :create_access_tokens
  many :contributions

  mount_uploader :gift_event_image, GiftEventImageUploader
  

  private
  
  def create_access_tokens
    self.gift_admin_token = ActiveSupport::SecureRandom.hex(16)
    self.access_token = ActiveSupport::SecureRandom.hex(16)
  end
end