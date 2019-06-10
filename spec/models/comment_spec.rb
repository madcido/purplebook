require 'rails_helper'

RSpec.describe Comment do
    describe "association" do
        it { should belong_to(:user) }
        it { should belong_to(:post) }
        it { should have_many(:likes) }
    end

    describe "validation" do
        it "doesn't accept blank user_id, post_id or content" do
            @comment = build(:comment, post_id: nil, user_id: nil, content: nil)
            @comment.valid?
            expect(@comment.errors.count).to eql(3)
        end
    end
end
