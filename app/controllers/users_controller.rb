class UsersController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }
    before_action :get_user, only: [:show, :update]
    before_action :get_objects, only: [:show]

    def index
        @users = User.where.not(id: current_user.id).all
        @new_friend = Friendship.new()
    end

    def show
        @new_friend = Friendship.new()
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Profile updated"
        else
            flash[:error] = "Update failed"
        end
        redirect_to @user
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :bio)
    end

    def get_user
        @user = User.find_by(id: params[:id])
    end

end
