require 'rails_helper'

RSpec.describe FriendshipsController do
    context "with user logged out" do
        it "redirects to login page" do
            @friendship = create(:friendship)
            post :create
            expect(response).to redirect_to(new_user_session_path)
            put :update, params: { id: @friendship.id }
            expect(response).to redirect_to(new_user_session_path)
            delete :destroy, params: { id: @friendship.id }
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
                @other_user = create(:user)
                expect do
                    post :create, format: :js, params: { friendship: { sender_id: user.id, receiver_id: @other_user.id } }
                end.to change(Friendship.pending, :count).by(1)
            end
        end

        describe "#update" do
            it "changes from pending to accepted" do
                @friendship = create(:friendship)
                expect do
                    put :update, format: :js, params: { id: @friendship.id, friendship: { pending: false } }
                end.to change(Friendship.accepted, :count).by(1)
            end
        end

        describe "#destroy" do
            it "removes from database" do
                @friendship = create(:friendship)
                expect do
                    delete :destroy, format: :js, params: { id: @friendship.id }
                end.to change(Friendship, :count).by(-1)
            end
        end
    end
end
