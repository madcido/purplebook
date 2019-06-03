class PostsController < ApplicationController
    before_action { redirect_to new_user_session_path unless current_user }
    before_action :get_post, only: [:show, :edit, :update]
    before_action :get_objects, only: [:index, :show]

    def index
        @posts = Post.where(user_id: current_user.friends.ids << current_user.id).all.includes(:comments).includes(:likers).paginate(page: params[:page], per_page: 20)
    end

    def create
        @post = current_user.posts.build(post_params)
        attach_shared_file if params[:shared]
        if @post.save
            flash[:success] = "Post created"
        else
            flash[:error] = "Post can't be blank"
        end
        redirect_to root_path
    end

    def show; end

    def edit; end

    def update
        if update_has_content? && @post.update(post_params)
            @post.image.purge if params[:purge]
            flash[:success] = "Post updated"
        else
            flash[:error] = "Post can't be blank"
        end
        redirect_to @post
    end

    def destroy
        Post.find_by(id: params[:id]).destroy
        flash[:success] = "Post deleted"
        redirect_to request.referrer
    end

    private

    def post_params
        params.require(:post).permit(:content, :image, :shared_from_id)
    end

    def get_post
        @post = Post.find_by(id: params[:id])
    end

    def attach_shared_file
        @post.image.attach(Post.find_by(id: params[:shared]).image.blob)
    end

    def update_has_content?
        !(params[:purge] && params[:post][:content].empty?)
    end

end
