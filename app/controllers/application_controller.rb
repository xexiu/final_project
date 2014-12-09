class ApplicationController < ActionController::Base
  after_filter :flash_to_headers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def flash_to_headers
     return unless request.xhr?
     response.headers['X-Message'] = flash_message
     response.headers["X-Message-Type"] = flash_type.to_s

     flash.discard # don't want the flash to appear when you reload page
  end

private

  def flash_message
     [:error, :success, :danger, :warning, :notice, nil].each do |type|
       return "" if type.nil?
       return flash[type] unless flash[type].blank?
     end
  end

  def flash_type
     [:error, :success, :danger, :warning, :notice, nil].each do |type|
         return "" if type.nil?
         return type unless flash[type].blank?
     end
  end

end
