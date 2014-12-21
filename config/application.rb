require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Palestrascoletivas
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.i18n.load_path += Dir["app/locales/**/*.yml"]
    config.i18n.default_locale = "pt-BR"
    config.i18n.available_locales = ["pt-BR", "en"]
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    I18n.enforce_available_locales = true
  end
end
