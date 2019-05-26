class PostsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }
    before_action :get_post, only: [:show, :edit, :update]

    def index
        @posts = Post.all.includes(:comments).includes(:likers)
        @new_post = Post.new()
        @new_like = Like.new()
        @new_comment = Comment.new()
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created"
            redirect_to root_path
        else
            flash[:error] = "Post can't be blank"
            redirect_to root_path
        end
    end

    def show
        @new_like = @new_like = Like.new()
    end

    def edit; end

    def update
        if params[:post][:image]
            @post.update(content: params[:post][:content], image: params[:post][:image])
            flash[:success] = "Post updated"
        elsif params[:post][:purge] == "keep" && @post.update(content: params[:post][:content])
            flash[:success] = "Post updated"
        elsif params[:post][:content] != "" || @post.content != ""
            @post.image.purge if params[:post][:purge] == "purge"
            @post.update(content: params[:post][:content])
            flash[:success] = "Post updated"
        else
            flash[:error] = "Post can't be blank"
        end
        redirect_to @post
    end

    def destroy
        Post.find_by(id: params[:id]).destroy
        flash[:success] = "Post deleted"
        redirect_to root_path
    end

    private

    def post_params
        params.require(:post).permit(:content, :image)
    end

    def get_post
        @post = Post.find_by(id: params[:id])
    end

end
