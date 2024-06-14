require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ConnamaraTest
  class Application < Rails::Application
    config.load_defaults 7.1
    config.middleware.use Rack::Deflater

    config.autoload_lib(ignore: %w(assets tasks))

    env_file = File.join(Rails.root, 'config', 'local_env.yml')
    if File.exist?(env_file)
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end
    end

    config.paths.add File.join('app', 'services'), glob: File.join('**', '*.rb')

    config.active_job.queue_adapter = :solid_queue

    config.api_only = true
  end
end
