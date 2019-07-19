class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found?

  def not_found?
    render file: "#{Rails.root}/public/404.html", status: 403, layout: false
  end
end
