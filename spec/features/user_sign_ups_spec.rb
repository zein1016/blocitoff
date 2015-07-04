require 'rails_helper'

feature "User signs up", type: :feature do
  # before do
  #   click_link "Sign up"
  #   expect(current_path).to eq(new_user_registration_path)
  #   fill_in "Name", with: "Test"
  #   fill_in "Surname", with: "Test"
  #   fill_in "Email", with: "tester@example.tld"
  #   fill_in "Password", with: "test-password"
  #   fill_in "Password confirmation", with: "test-password"
  #   click_button "Sign up"
  # end

  scenario "successfully" do
    visit "/"

    click_link "Sign up"
    expect(current_path).to eq(new_user_registration_path)
    fill_in "Name", with: "Test"
    fill_in "Surname", with: "Test"
    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    fill_in "Password confirmation", with: "test-password"
    click_button "Sign up"

    expect(current_path).to eq "/"
    expect(page).to have_content(
      "A message with a confirmation link has been sent to your email address.
      Please follow the link to activate your account."
    )

    open_email "tester@example.tld", with_subject: "Confirmation instructions"
    visit_in_email "Confirm my account"

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "Your email address has been successfully confirmed."

    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    click_button "Log in"

    expect(current_path).to eq "/"
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "Hello Test"


  end

  scenario "usuccessfully - Invalid email " do
    visit "/"

    click_link  "Sign up"
    expect(current_path).to eq(new_user_registration_path)
    fill_in "Name", with: "Test"
    fill_in "Surname", with: "Test"
    fill_in "Email", with: "invalid-email"
    fill_in "Password", with: "test-password"
    fill_in "Password confirmation", with: "test-password"
    click_button "Sign up"
    expect(current_path).to eq "/users"
    expect(page).to have_content(
      "Email is invalid"
        )
  end
  scenario "usuccessfully - Duplicate email " do
    visit "/"

    click_link "Sign up"
    expect(current_path).to eq(new_user_registration_path)
    fill_in "Name", with: "Test"
    fill_in "Surname", with: "Test"
    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    fill_in "Password confirmation", with: "test-password"
    click_button "Sign up"
    expect(current_path).to eq "/users"
    expect(page).to have_content(
      "Email has already been taken"
        )
  end

end

feature "User signing", type: :feature do
  scenario "usuccessfully" do
    visit "/"

    click_link "Sign in"
    expect(current_path).to eq(new_user_session_path)
    fill_in "Email", with: "wrong-email@example.tld"
    fill_in "Password", with: "wrong-password"
    click_button "Log in"

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content(
      "Invalid email or password."
    )

    # expect(current_path).to eq new_user_session_path
    # expect(page).to have_content "Your email address has been successfully confirmed."

    # fill_in "Email", with: "tester@example.tld"
    # fill_in "Password", with: "test-password"
    # click_button "Log in"

    # expect(current_path).to eq "/"
    # expect(page).to have_content "Signed in successfully."
    # expect(page).to have_content "Hello Zein"


  end
end
