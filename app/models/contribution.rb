class Contribution
  include MongoMapper::EmbeddedDocument

  key :name, String, :required => true
  key :email, String, :required => true, :format => RFC822::EmailAddress
  key :amount, Float, :required => true

end