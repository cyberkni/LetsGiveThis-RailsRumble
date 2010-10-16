class GiftEvent
  include MongoMapper::Document

  key :gift_admin_email, String, :required => true, :format => RFC822::EmailAddress
  key :gift_admin_key, String, :required => true
  key :gift_key, String, :required => true
  key :gift_name, String, :required => true
  key :gift_price, Float, :required => true
  key :gift_link, String
  key :gift_file_path, String

#  many :contributions

end