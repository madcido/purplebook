require 'rails_helper'

feature "Comments" do
    let(:ze) { FactoryBot.create :user, name: "ze" }

    it "can be made on posts" do
        visit new_user_session_path
        fill_in "Email", with: ze.email
        fill_in "Password", with: ze.password
        click_on "Log in"
        post = create(:post, user_id: ze.id)
        visit current_path
        expect(page).to have_content("0 Comments")
        comment = create(:comment, user_id: ze.id, post_id: post.id, content: "I'm a comment.")
        visit current_path
        expect(page).to have_content("1 Comment")
        expect(page).to have_content("I'm a comment.")
    end
end
