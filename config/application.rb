require_relative "boot"

require "rails/all"

if defined?(Rails::Server) && Rails.env.development?
  require "debug/open_nonstop"
end

Bundler.require(*Rails.groups)

module Piazza
  class Application < Rails::Application
    config.load_defaults 7.0

    config.exceptions_app = ->(env) {
      ErrorsController.action(:show).call(env)
    }

    config.action_view
      .prefix_partial_path_with_controller_namespace = false
  end
end
