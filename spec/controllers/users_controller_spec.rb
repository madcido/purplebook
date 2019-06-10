require 'rails_helper'

RSpec.describe UsersController do
    context "with user logged out" do
        it "redirects to login page" do
            @user = create(:user)
            get :index
            expect(response).to redirect_to(new_user_session_path)
            get :show, params: { id: @user.id }
            expect(response).to redirect_to(new_user_session_path)
            put :update, params: { id: @user.id }
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context "with user logged in" do
        describe "#update" do
            it "changes user data" do
                @user = create(:user, name: "ze", bio: "farofa no pe")
                sign_in(@user)
                expect(@user.name).to eql("ze")
                expect(@user.bio).to eql("farofa no pe")
                put :update, { params: { id: @user.id, user: { name: "jao", bio: "comeu macarrao" } } }
                @user.reload
                expect(@user.name).to eql("jao")
                expect(@user.bio).to eql("comeu macarrao")
                expect(response).to redirect_to(user_path(@user.friendly_id))
            end
        end
    end
end
