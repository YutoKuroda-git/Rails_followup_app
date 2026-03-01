# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [ :update ]
  before_action :restrict_guest!, only: [ :edit, :update, :destroy ]

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :avatar, :remove_avatar ])
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
