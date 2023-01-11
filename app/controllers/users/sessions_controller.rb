# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController

    def create
      request.params[:user].merge!(params.require(:user).permit(:username))
      super
      save_session_token
    end

    private

    def save_session_token
      token = Devise.friendly_token
      session[:user_token] = token
      resource.update(session_token: token)
    end

    def after_sign_in_path_for(_resource_or_scope)
      user_root_path
    end

    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end
  end
end
