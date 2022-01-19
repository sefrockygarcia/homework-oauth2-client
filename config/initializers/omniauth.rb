require File.expand_path('lib/omniauth/strategies/homework', Rails.root)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :homework, ENV['APP_ID'], ENV['APP_SECRET'], provider_ignores_state: true
end