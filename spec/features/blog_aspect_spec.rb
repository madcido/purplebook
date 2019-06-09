require 'rails_helper'

feature "User can post stuff and" do
    let(:ze) { FactoryBot.create :user, name: "ze" }
    before :each do
        visit new_user_session_path
        fill_in "Email", with: ze.email
        fill_in "Password", with: ze.password
        click_on "Log in"
        expect(page).to have_selector(:label, "Create Post")
        fill_in "Create Post", with: "Hello, this is Ze's post."
        click_on "Share"
    end

    it "see his own post" do
        expect(page).to have_content("Hello, this is Ze's post.")
        expect(page).to have_selector(:label, "Like")
        expect(page).to have_selector(:label, "Comment")
        expect(page).to have_selector(:label, "Share")
    end

    it "edit his own post" do
        expect(page).to have_selector(:link, "Edit")
        click_on "Edit"
        fill_in "post[content]", with: "Ze's edited post."
        click_on "Save"
        expect(page).to_not have_content("Hello, this is Ze's post.")
        expect(page).to have_content("Ze's edited post.")
    end

    it "delete his own post" do
        expect(page).to have_selector(:link, "Delete")
        click_on "Delete"
        expect(page).to_not have_content("Hello, this is Ze's post.")
    end
end
