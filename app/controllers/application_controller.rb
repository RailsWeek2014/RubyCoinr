class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :create_receiverqrcode

  # attribution: http://stackoverflow.com/questions/23555618/redirect-to-log-in-page-if-user-is-not-authenticated-with-devise
  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, :notice => 'Please sign in or sign up before proceeding.'
    end
  end

  private
  def create_receiverqrcode
  	@receiverqrcode = Receiverqrcode.new
  end
end
