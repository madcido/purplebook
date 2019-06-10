require 'rails_helper'

RSpec.describe User do
    describe "association" do
        it { should have_many(:posts) }
        it { should have_many(:comments) }
        it { should have_many(:likes) }
    end

    describe "validation" do
        it "doesn't accept blank email or password" do
            @user = build(:user, email: nil, password: nil, password_confirmation: nil)
            @user.valid?
            expect(@user.errors.count).to eql(2)
        end

        it "doesn't accept short password" do
            @user = build(:user, password: "hello")
            @user.valid?
            expect(@user.errors[:password]).to eql(["is too short (minimum is 6 characters)"])
        end

        it "doesn't accept confirmation different from password" do
            @user = build(:user, password: "hello123", password_confirmation: "byebye")
            @user.valid?
            expect(@user.errors[:password_confirmation]).to eql(["doesn't match Password"])
        end
    end

    describe ":friends method" do
        it "should find all your friends" do
            @ze = create(:user)
            @jao = create(:user)
            @maria = create(:user)
            @friendship1 = create(:friendship, sender_id: @ze.id, receiver_id: @jao.id)
            @friendship2 = create(:friendship, sender_id: @ze.id, receiver_id: @maria.id, pending: false)
            @friendship3 = create(:friendship, sender_id: @maria.id, receiver_id: @jao.id, pending: false)
            expect(@ze.friends.ids).to eql([@maria.id])
            expect(@jao.friends.ids).to eql([@maria.id])
            expect(@maria.friends.ids).to eql([@ze.id, @jao.id])
        end
    end
end
