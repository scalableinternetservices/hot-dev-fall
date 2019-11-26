require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SubscriptionSharing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store, { size: 64.megabytes }

    # TODO: Configure/deploy memcache instead of in memory
    # config.cache_store = :dalli_store, 'http://localhost:12111',
    # { :namespace => "HOT-DEV-FALL", :expires_in => 1.day, :compress => true }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
