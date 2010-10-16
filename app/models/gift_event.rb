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

  before_validation :create_access_tokens
  many :contributions

  private
  
  def create_access_tokens
    self.gift_admin_token = ActiveSupport::SecureRandom.hex(16)
    self.access_token = ActiveSupport::SecureRandom.hex(16)
  end
end