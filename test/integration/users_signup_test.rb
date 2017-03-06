require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name: "Example User",
                                         email: "example@example.com",
                                         password: "password",
                                         password_confirmation: "password"} }
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
  end

end

# The URLs for an unsubmitted signup form and for a submitted signup form are /signup and /users, respectively, which don’t match. This is due to our use of a custom named route in the former case (added in Listing 5.43) and a default RESTful route in the latter case (Listing 7.3). Resolve this discrepancy by adding the code shown in Listing 7.26 and Listing 7.27. Submit the new form to confirm that both cases now use the same /signup URL. Are the tests still green? Why?
# Update the post in Listing 7.25 to use the new URL from the previous exercise. Confirm that the tests are still green.
# Confirm by reverting Listing 7.27 to its previous form (Listing 7.20) that the tests are still green. This is a problem, because the URL being posted to isn’t right. Add an assert_select to the test in Listing 7.25 to catch this bug and get to red, then change the form back to Listing 7.27 to get the tests green again. Hint: Test for the presence of ’form[action="/signup"]’ before posting to the form in the test.
