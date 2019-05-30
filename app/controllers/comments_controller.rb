class CommentsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            flash[:success] = "Comment created"
        else
            flash[:error] = "Comment can't be blank"
        end
        redirect_to request.referrer
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
