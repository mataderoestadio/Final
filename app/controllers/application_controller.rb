class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :gender, :position])
      end

    def authorize_admin 
        redirect_to rooth_path, alert: 'Acceso denegado' unless current_user.admin?
    end


    def authorize_request(kind = nil)
        unless kind.include?(current_user.role)
        redirect_to jobs_path, notice: "You are not authorized to perform this action"
        end
    end
end
