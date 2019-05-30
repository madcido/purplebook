class LikesController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }

    def create
        @like = Like.new(like_params)
        if @like.save
            flash[:success] = "Like added"
        else
            flash[:error] = "Like failed"
        end
        redirect_to request.referrer
    end

    def destroy
        Like.find_by(id: params[:id]).destroy
        flash[:success] = "Like removed"
        redirect_to request.referrer
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :liked_type, :liked_id)
    end

end
