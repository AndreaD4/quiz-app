require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QuizApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_record.belongs_to_required_by_default = false
    config.active_storage.replace_on_assign_to_many = false

    config.time_zone = 'Rome'

    config.app = 'QuizApp'
    config.app_flavor = 'QuizApp'
    config.copyright = "2021 © QuizApp by&nbsp;<a href='https://www.netsoftware83.it/' class='text-primary fw-500' title='https://www.netsoftware83.it/' target='_blank'>NetSoftware83</a>".html_safe
    config.copyright_inverse = "2022 © QuizApp".html_safe
    config.app_name = 'QuizApp'

    config.active_job.queue_adapter = :delayed_job
    config.i18n.default_locale = :it

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
