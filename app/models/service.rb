class Service < ApplicationRecord

  def client
    HTTP.auth("Bearer #{access_token}")
  end

  def expired?
    expires_at? && expires_at <= Time.zone.now
  end

  def access_token
    send("#{provider}_refresh_token!", super) if expired?
    super
  end
end
