class GiftEvent
  include MongoMapper::Document
  include Paperclip::Glue

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
  key :gift_short_link, String
  timestamps!
  
  before_validation :create_access_tokens, :generate_short_link
  many :contributions

  PORT = /(([:]\d+)?)/
  DOMAIN = /([a-z0-9\-]+\.?)*([a-z0-9]{2,})\.[a-z]{2,}/
  NUMERIC_IP = /(?>(?:1?\d?\d|2[0-4]\d|25[0-5])\.){3}(?:1?\d?\d|2[0-4]\d|25[0-5])(?:\/(?:[12]?\d|3[012])|-(?>(?:1?\d?\d|2[0-4]\d|25[0-5])\.){3}(?:1?\d?\d|2[0-4]\d|25[0-5]))?/

  validates_format_of :gift_link, :with => /^(http:\/\/|https:\/\/)*((localhost)|#{DOMAIN}|#{NUMERIC_IP})/
#  validates_format_of :gift_link, :with => /^(((localhost)|#{DOMAIN}|#{NUMERIC_IP})#{PORT})|$/

  has_attached_file :image, :styles => { :medium => "600x600>", :thumb => "200x200>" }

  after_save :check_for_completion_and_notify

  def contribution_total
    contributions.inject(0) do |sum, c|
      sum += c.amount
    end
  end

  def percent_done
    (contribution_total / gift_price) * 100
  end

  def amount_remaining
    gift_price - contribution_total
  end

  private

  def create_access_tokens
    if self.gift_admin_token.blank?
      self.gift_admin_token = ActiveSupport::SecureRandom.hex(16)
    end
    if self.access_token.blank?
      self.access_token = ActiveSupport::SecureRandom.hex(16)
    end
  end
  
  def generate_short_link
    bitly = Mush::Services::Bitly.new
    bitly.login = "letsgivethis"
    bitly.apikey = "R_11d45c6bcc9f53f7ab38ace79fd6bc1e"
    
    if self.gift_short_link.blank?
      # I know there must be a better way than this...
      self.gift_short_link = bitly.shorten "http://letsgivethis.com/event/#{self.access_token}"
    end
  end
  
  def check_for_completion_and_notify
    if self.amount_remaining <= 0
      Notifier.over_the_line(self).deliver
    end
  end
end
