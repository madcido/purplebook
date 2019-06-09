require 'rails_helper'

RSpec.describe LikesController do
    context "with user logged out" do
        it "redirects to login page" do
            @post_like = create(:post_like)
            @comment_like = create(:comment_like)
            post :create
            expect(response).to redirect_to(new_user_session_path)
            delete :destroy, params: { id: @post_like.id }
            expect(response).to redirect_to(new_user_session_path)
            delete :destroy, params: { id: @comment_like.id }
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context "with user logged in" do
        let(:user) { FactoryBot.create :user }
        before :each do
            sign_in(user)
        end

        describe "#create" do
            it "saves to database" do
                @post = create(:post)
                @comment = create(:comment)
                expect do
                    post :create, format: :js, params: { like: { user_id: user.id, liked_id: @post.id, liked_type: "Post" } }
                    post :create, format: :js, params: { like: { user_id: user.id, liked_id: @comment.id, liked_type: "Comment" } }
                end.to change(Like, :count).by(2)
            end
        end

        describe "#destroy" do
            it "removes from database" do
                @post_like = create(:post_like)
                @comment_like = create(:comment_like)
                expect do
                    delete :destroy, format: :js, params: { id: @post_like.id }
                    delete :destroy, format: :js, params: { id: @comment_like.id }
                end.to change(Like, :count).by(-2)
            end
        end
    end
end
