# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #skip_before_action :require_no_authentication, only: [:new, :create]
  #prepend_before_filter :require_no_authentication, only: [:cancel ]
  #before_action :configure_sign_up_params, only: [:create]
  #before_filter :authorize_admin, only [:create, :new]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_no_authentication, only: [:new, :create]
 

  # GET /resource/sign_up
  def new
    if current_user.admin?
      super
    else
    redirect_to root_path  
    render json: {"only admins site"}
  end

  # POST /resource
  def create
    if current_user.admin?
      @users = User.new(user_params)
        if @users.save
          redirect_to root_path,
            render json: { status: '201', message: 'User created successfully' }
        else
            render json: { status: '400', message: 'Invalid user info', data: @users.errors }
        end
  end

  def show
  @user = User.find(params[:id])
  end

  
  
  # GET /resource/edit
  # def edit
  #   super
  # end
  
  # PUT /resource
  # def update
  #   super
  # end
  
  # DELETE /resource
  # def destroy
  #   super
  # end
  
  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  
  # protected
  
  If you have extra params to permit, append them to the sanitizer.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :gender, :position])
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end
  
  def after_sign_up_path_for(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    root_path
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
end
