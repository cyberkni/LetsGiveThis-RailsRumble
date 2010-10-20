class Contribution
  include MongoMapper::EmbeddedDocument

  key :name, String, :required => true
  key :email, String, :required => true, :format => RFC822::EmailAddress
  key :amount, Float, :required => true
  validate :amount_greater_than_zero
  
  def amount_greater_than_zero
    unless amount > 0
      errors.on :amount, "must be greater than zero."
    end
  end

end