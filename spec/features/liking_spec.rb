require 'rails_helper'

feature "Likes" do
    let(:ze) { FactoryBot.create :user, name: "ze" }
    before :each do
        visit new_user_session_path
        fill_in "Email", with: ze.email
        fill_in "Password", with: ze.password
        click_on "Log in"
    end

    it "can be made on posts" do
        post = create(:post, user_id: ze.id)
        visit current_path
        expect(page).to have_content("0 Likes")
        like = create(:post_like, user_id: ze.id, liked_id: post.id)
        visit current_path
        expect(page).to have_content("1 Like")
    end

    it "can be made on comments" do
        post = create(:post, user_id: ze.id)
        comment = create(:comment, user_id: ze.id, post_id: post.id)
        visit current_path
        expect(page).to_not have_css(".comment-likes")
        like = create(:comment_like, user_id: ze.id, liked_id: comment.id)
        visit current_path
        expect(page.find(:css, ".comment-likes")).to have_content("1")
    end
end
