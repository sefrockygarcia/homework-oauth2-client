# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

if ENV['APP_ID'].blank? || ENV['APP_SECRET'].blank? || ENV['PROVIDER_URL'].blank? || ENV['CLIENT_URL'].blank?
  raise 'Please set ENV variables APP_ID, APP_SECRET, PROVIDER_URL and CLIENT_URL!'
end

run Rails.application
Rails.application.load_server
