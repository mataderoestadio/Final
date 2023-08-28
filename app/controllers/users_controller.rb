class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :is_admin?
  
    def index
      @users = User.where.not(:id => current_user.id)
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      # if params[:user][:password].blank?
      #   params[:user].delete(:password)
      #   params[:user].delete(:password_confirmation)
      # end
      # password_setting(@user)
  
      if @user.save
        flash[:notice] = "Successfully created User."
        redirect_to root_path
        # TODO Enviar mail con password
      else
        flash[:alert] = @user.errors.full_messages
        render :action => 'new'
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
  
      if @user.update(user_params)
        flash[:notice] = "Successfully updated User."
        redirect_to root_path
      else
        respond_to do |format|
          format.html { redirect_to new_user_path, alert: @user.errors.full_messages }
        end
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      if @user.destroy
        flash[:notice] = "Successfully deleted User."
        redirect_to root_path
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :name,
        :age,
        :gender,
        :position,

      )
    end
  
    # def password_setting(user)
    #   generated_password = Devise.friendly_token.first(8)
  
    #   user.password = generated_password
    #   user.password_confirmation = generated_password
    #   generated_password
    # end
  
    def is_admin?
      if not current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, alert: "Only admins can access" }
        end
      end
    end
  end