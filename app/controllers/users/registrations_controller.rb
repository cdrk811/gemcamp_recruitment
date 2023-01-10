# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: :create

    def create
      set_resource_attributes
      if resource.save
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
        save_session_token
      else
        render :new
      end
    end

    def update
      if resource.update_with_password(update_user_params)
        bypass_sign_in(resource, scope: :user)
        flash[:notice] = t('.notice')
        redirect_to user_root_path
      else
        flash.now[:error] = t('.error')
        render :edit
      end
    end

    private

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up) do |admin_user|
        admin_user.permit(:username, :password, :password_confirmation)
      end
    end

    def after_sign_up_path_for(_resource_or_scope)
      user_root_path
    end

    def set_resource_attributes
      username = params[:user][:username]
      self.resource = resource_class.new(
        email: "#{username}@friendly.com",
        password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation],
        username: username
      )
    end

    def save_session_token
      token = Devise.friendly_token
      session[:user_token] = token
      resource.update(session_token: token)
    end

    def update_user_params
      param_key = resource.model_name.param_key.to_sym
      params.require(param_key).permit(:current_password, :password, :password_confirmation)
    end
  end
end