require 'rails_helper'

RSpec.describe Post do
    describe "association" do
        it { should belong_to(:user) }
        it { should have_many(:comments) }
        it { should have_many(:likes) }
    end

    describe "validation" do
        it "doesn't accept blank user_id or content" do
            @post = build(:post, user_id: nil, content: nil)
            @post.valid?
            expect(@post.errors.count).to eql(2)
        end
    end
end
