class PostsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }
    before_action :get_post, only: [:show, :edit, :update]
    before_action :get_objects, only: [:index, :show]

    def index
        @posts = Post.all.includes(:comments).includes(:likers)
    end

    def create
        @post = current_user.posts.build(post_params)
        # problem with attaching file here, possibility to create empty post
        if @post.save
            attach_file
            flash[:success] = "Post created"
        else
            flash[:error] = "Post can't be blank"
        end
        redirect_to root_path
    end

    def show; end

    def edit; end

    def update
        if attached_file? || keep_file?
            flash[:success] = "Post updated"
        elsif present_content?
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
        params.require(:post).permit(:content, :shared_from_id)
    end

    def get_post
        @post = Post.find_by(id: params[:id])
    end

    def attach_file
        if params[:post][:share]
            @post.image.attach(Post.find_by(id: params[:post][:share]).image.blob)
        else
            @post.image.attach(params[:post][:image]) unless params[:post][:image].nil?
        end
    end

    def attached_file?
        params[:post][:image] && @post.update(content: params[:post][:content], image: params[:post][:image])
    end

    def keep_file?
        params[:post][:purge] == "keep" && @post.update(content: params[:post][:content])
    end

    def present_content?
        params[:post][:content] != "" || @post.content != ""
    end

end
