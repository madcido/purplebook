require 'rails_helper'

feature "Friendship mechanics" do
    let(:ze) { FactoryBot.create :user, name: "ze" }
    let(:jao) { FactoryBot.create :user, name: "jao" }

    it "only permits friends to see your posts" do
        visit new_user_session_path
        fill_in "Email", with: ze.email
        fill_in "Password", with: ze.password
        click_on "Log in"
        fill_in "Create Post", with: "Hello, this is Ze's post."
        click_on "Share"
        expect(page).to have_content("Hello, this is Ze's post.")
        click_link href: destroy_user_session_path
        fill_in "Email", with: jao.email
        fill_in "Password", with: jao.password
        click_on "Log in"
        expect(page).to_not have_content("Hello, this is Ze's post.")
        friendship = create(:friendship, sender_id: ze.id, receiver_id: jao.id, pending: false)
        visit current_path 
        expect(page).to have_content("Hello, this is Ze's post.")
    end
end
