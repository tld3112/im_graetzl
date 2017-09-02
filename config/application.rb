require_relative 'boot'

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImGraetzl
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.active_record.time_zone_aware_types = [:datetime, :time]

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    #config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    # Set default locale to german
    config.i18n.default_locale = :de
    # Set path for nested translation files
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # add mailer concerns
    config.eager_load_paths += %W(#{config.root}/app/mailers/concerns)

    # Disable Rails field_with_errors
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      html_tag.html_safe
    end

    config.middleware.use Rack::Attack

    # Rack middleware to redirect urls with trailing slash
    config.middleware.insert_before(0, Rack::Rewrite) do
      r301 %r{^/(.*)/$}, '/$1'
    end

    config.middleware.insert_before(0, Rack::Cors) do
      allow do
        origins /imgraetzl\.at(:\d+)?/
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end

    config.active_job.queue_adapter = :sucker_punch
  end
end
