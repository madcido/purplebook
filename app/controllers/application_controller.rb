class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def get_objects
        @new_post = Post.new()
        @new_like = Like.new()
        @new_comment = Comment.new()
        @comments = Comment.all
    end
    
end
