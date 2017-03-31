require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SuperDemo
  class Application < Rails::Application
    config.generators do |g|
      g.orm :active_record
      g.template_engine :erb
      g.test_framework :rspec
      g.stylesheets false
      g.javascript false
    end
    config.i18n.default_locale = :en
    I18n.enforce_available_locales = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
