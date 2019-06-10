require 'rails_helper'

RSpec.describe PostsController do
    context "with user logged out" do
        it "redirects to login page" do
            @post = create(:post)
            get :index
            expect(response).to redirect_to(new_user_session_path)
            post :create
            expect(response).to redirect_to(new_user_session_path)
            get :show, params: { id: @post.id }
            expect(response).to redirect_to(new_user_session_path)
            get :edit, params: { id: @post.id }
            expect(response).to redirect_to(new_user_session_path)
            put :update, params: { id: @post.id }
            expect(response).to redirect_to(new_user_session_path)
            delete :destroy, params: { id: @post.id }
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context "with user logged in" do
        let(:user) { FactoryBot.create :user }
        before :each do
            sign_in(user)
        end

        describe "#create" do
            it "saves to database and redirects" do
                expect do
                    post :create, params: { post: { content: Faker::ChuckNorris.fact } }
                end.to change(Post, :count).by(1)
                expect(response).to redirect_to(root_path)
            end
        end

        describe "#update" do
            it "changes post content and redirects" do
                @post = create(:post, content: "Tudo viado")
                expect(@post.content).to eql("Tudo viado")
                put :update, { params: { id: @post.id, post: { content: "Sem zuar, tudo viado" } } }
                @post.reload
                expect(@post.content).to eql("Sem zuar, tudo viado")
                expect(response).to redirect_to(post_path)
            end
        end

        describe "#destroy" do
            it "removes from database and redirects" do
                @post = create(:post)
                expect do
                    delete :destroy, params: { id: @post.id }
                end.to change(Post, :count).by(-1)
                expect(response).to redirect_to(root_path)
            end
        end
    end
end
