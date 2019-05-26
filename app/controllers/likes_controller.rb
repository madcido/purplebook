class LikesController < ApplicationController

    def create
        @like = Like.new(like_params)
        if @like.save
            flash[:success] = "Like added"
            redirect_to request.referrer
        else
            flash[:error] = "Like failed"
            redirect_to request.referrer
        end
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
