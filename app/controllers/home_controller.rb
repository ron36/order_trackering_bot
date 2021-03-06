class HomeController < ApplicationController
  def index
    Rails.logger.info 'Nothing to Do here!'
  end

  def shorten
    long_url = params[:shorten][:url]
    @url = generate_url(long_url)
  end

  def generate_url(param)
    uri = URI.parse(param)

    uri = "http://#{uri.to_s}" unless valid? uri
    unique_key = nil
    unique_key = Shortener::ShortenedUrl.generate(uri, owner: current_user).unique_key unless uri.to_s.blank?
    "#{root_url}#{unique_key}"
  end

  def valid?(uri)
    uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
