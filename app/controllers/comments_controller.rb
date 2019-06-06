class CommentsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }

    def create
        @comment = current_user.comments.build(comment_params)
        respond_to { |format| format.js if @comment.save }
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @comment.destroy
        respond_to { |format| format.js }
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end

end
