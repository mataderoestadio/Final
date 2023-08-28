# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #skip_before_action :require_no_authentication, only: [:new, :create]
  #prepend_before_filter :require_no_authentication, only: [:cancel ]
  #prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  before_action :authenticate_user!, only:[:edit, :update]
  before_action :authenticate_admin!, only: [:new, :create]
  before_action :is_admin?
  #before_action :configure_sign_up_params, only: [:create]

  #before_action :configure_sign_up_params, only: [:create, :edit]
  #before_action :configure_account_update_params, only: [:update, :edit]
  #skip_before_action :require_no_authentication, only: [:new, :create]
 

  # GET /resource/sign_up
#   def new
#     if current_user.is_admin?
#  super 
#     end
#   end

def create
  @user = User.new(user_params)

  if @user.save
    flash[:notice] = "Successfully created User."
    redirect_to root_path
    # TODO Enviar mail con password
  else
    flash[:alert] = @user.errors.full_messages
    render :action => 'new'
  end
end


  # POST /resource
  # def create
  #   super
  # end

  # def show
  # @user = User.find(params[:id])
  # end

  
  
  # GET /resource/edit
  # def edit
  #   super
  # end
  
  # PUT /resource
  #  def update
  #    super
  #  end
  
  #  DELETE /resource
  #  def destroy
  #    super
  #  end
  
  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  
  protected
  
  #If you have extra params to permit, append them to the sanitizer.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :age, :gender, :position])
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end
  
  # def after_sign_up_path_for(resource)
  #   root_path
  # end

  # The path used after sign up for inactive accounts.
  #def after_inactive_sign_up_path_for(resource)
    #root_path
  #end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


# def is_admin?
#   if not current_user.admin?
#     respond_to do |format|
#       format.html { redirect_to root_path, alert: "Only admins can access" }
#     end
#   end

#   def authorize_request(kind = nil)
#     unless kind.include?(current_user.role)
#     redirect_to posts_path, notice: "You are not authorized to perform this action"
#     end
# end


def authenticate_admin!
  unless current_user && current_user.admin?
    redirect_to root_path, alert: "Only admins can access this page."
  end
end 


    def is_admin?
      if not current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, alert: "Only admins can access" }
        end
      end
    end
  end
end
