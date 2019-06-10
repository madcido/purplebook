require 'rails_helper'

RSpec.describe Like do
    describe "association" do
        it { should belong_to :user }
        it { should belong_to :liked }
    end

    describe "validation" do
        it "doesn't accept blank liked_id or user_id" do
            @like = build(:post_like, user_id: nil, liked_id: nil)
            @like.valid?
            expect(@like.errors.count).to eql(2)
        end
        it "doesn't accept 2 likes from the same user" do
            @user = create(:user)
            @post = create(:post)
            @like1 = create(:post_like, user_id: @user.id, liked_id: @post.id)
            @like2 = build(:post_like, user_id: @user.id, liked_id: @post.id)
            expect(@like2.valid?).to eql(false)
        end
    end

    describe "factory" do
        it "creates a like for a post" do
            @like = build(:post_like)
            expect(@like.liked_type).to eql("Post")
        end
        it "creates a like for a comment" do
            @like = build(:comment_like)
            expect(@like.liked_type).to eql("Comment")
        end
    end
end
