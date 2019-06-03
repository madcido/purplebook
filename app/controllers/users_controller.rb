class UsersController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }
    before_action :get_user, only: [:show, :update]
    before_action :get_objects, only: [:show]

    def index
        if params[:search]
            @users = User.where("lower(name) LIKE ?", "%#{params[:search].downcase}%").all.paginate(page: params[:page], per_page: 10)
        else
            @users = User.all.paginate(page: params[:page], per_page: 10)
        end
        @new_friend = Friendship.new()
    end

    def show
        @new_friend = Friendship.new()
    end

    def update
        if @user.update(user_params)
            @user.avatar.purge if params[:purge]
            flash[:success] = "Profile updated"
        else
            flash[:error] = "Update failed"
        end
        redirect_to @user
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :bio, :avatar)
    end

    def get_user
        @user = User.friendly.find(params[:id])
    end

end
