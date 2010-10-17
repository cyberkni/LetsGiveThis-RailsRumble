# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Letsgivethis::Application.initialize!

# Turn off auto TLD
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false

# Restrict SASS to SCSS
sass_options = {
  :syntax => :scss
}