class HomeworkController < ApplicationController

  def callback
    if service.present?
      service.update! service_params
    else
      Service.create! service_params
    end

    redirect_to root_url
  end

  private
    def auth
      @auth ||= request.env["omniauth.auth"]
    end

    def service
      @service ||= Service.where(provider: 'homework', uid: ENV['APP_ID']).first
    end

    def service_params
      expires_at = auth.credentials.expires_at.present? ? Time.at(auth.credentials.expires_at) : nil
      
      {
        provider: 'homework',
        uid: ENV['APP_ID'],
        expires_at: expires_at,
        access_token: auth.credentials.token,
        access_token_secret: auth.credentials.secret,
        refresh_token: auth.credentials.refresh_token
      }
    end

end