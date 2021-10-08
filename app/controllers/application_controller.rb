class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about]

  private
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
  
    def after_sign_in_path_for(resource)
      user_path(current_user.id)
    end
  
    def after_sign_out_path_for(resource)
      root_path
    end

    def make_favorite_book_ids
      @favorite_book_ids = current_user.favorites.pluck(:book_id)
    end
end
