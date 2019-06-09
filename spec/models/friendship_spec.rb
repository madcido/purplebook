require 'rails_helper'

RSpec.describe Friendship do
    let(:ze) { FactoryBot.create :user }
    let(:jao) { FactoryBot.create :user }

    describe "association" do
        it "should belong to sender and receiver" do
            @friendship = build(:friendship, sender_id: ze.id, receiver_id: jao.id)
            expect(@friendship.valid?).to eql(true)
            expect(@friendship.sender).to eql(ze)
            expect(@friendship.receiver).to eql(jao)
        end
    end

    describe "validation" do
        it "doesn't accept same user as sender and requester" do
            @friendship = build(:friendship, sender_id: ze.id, receiver_id: ze.id)
            @friendship.valid?
            expect(@friendship.errors[:sender]).to eql(["can't be friends with self"])
        end
        it "doesn't accept same combination of users as sender and requester" do
            @friendship1 = create(:friendship, sender_id: ze.id, receiver_id: jao.id)
            @friendship2 = build(:friendship, sender_id: jao.id, receiver_id: ze.id)
            @friendship2.valid?
            expect(@friendship2.errors[:sender]).to eql(["and receiver already friends"])
        end
    end
end
