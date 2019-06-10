require 'rails_helper'

feature "Nice navbar" do
    let(:ze) { FactoryBot.create :user, name: "ze" }

    it "shows log in and sign up when logged out" do
        visit root_path
        expect(page).to have_selector(:link, "Log In")
        expect(page).to have_selector(:link, "Sign Up")
    end

    it "shows profile, home, users, notifications and log out when logged in" do
        visit new_user_session_path
        fill_in "Email", with: ze.email
        fill_in "Password", with: ze.password
        click_on "Log in"
        expect(page).to have_link(href: user_path(ze))
        expect(page).to have_link(href: root_path)
        expect(page).to have_link(href: users_path)
        expect(page).to have_selector(:label, "notifications-panel")
        expect(page).to have_link(href: destroy_user_session_path)
    end
end
