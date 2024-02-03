require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module LandscapeStock
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))
    config.autoload_paths << Rails.root.join('app', 'third_party', 'services')
    config.autoload_paths << Rails.root.join('app', 'third_party', 'dtos')
    config.autoload_paths << Rails.root.join('app', 'services', 'exceptions')

    config.api_only = true
  end
end
