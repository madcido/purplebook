class CommentsController < ApplicationController

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            flash[:success] = "Comment created"
            redirect_to request.referrer
        else
            flash[:error] = "Comment can't be blank"
            redirect_to request.referrer
        end
    end

    def destroy
        Comment.find_by(id: params[:id]).destroy
        flash[:success] = "Comment deleted"
        redirect_to request.referrer
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end

end
