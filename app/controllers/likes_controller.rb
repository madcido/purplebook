class LikesController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }

    def create
        @like = Like.new(like_params)
        @like.save
        respond_to { |format| format.js }
    end

    def destroy
        @like = Like.find_by(id: params[:id])
        @like.destroy
        respond_to { |format| format.js }
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :liked_type, :liked_id)
    end

end
