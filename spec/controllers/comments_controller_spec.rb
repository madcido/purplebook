require 'rails_helper'

RSpec.describe CommentsController do
    context "with user logged out" do
        it "redirects to login page" do
            @comment = create(:comment)
            post :create
            expect(response).to redirect_to(new_user_session_path)
            delete :destroy, params: { id: @comment.id }
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
                expect do
                    post :create, format: :js, params: { comment: { post_id: @post.id, content: Faker::ChuckNorris.fact } }
                end.to change(Comment, :count).by(1)
            end
        end

        describe "#destroy" do
            it "removes from database" do
                @comment = create(:comment)
                expect do
                    delete :destroy, format: :js, params: { id: @comment.id }
                end.to change(Comment, :count).by(-1)
            end
        end
    end
end
