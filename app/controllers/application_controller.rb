class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action {
    @projects = Project.all
  }

  protected
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_url, alert: exception.message
    else
      redirect_to new_user_session_path
    end
  end
end
