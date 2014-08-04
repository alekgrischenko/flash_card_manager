include ApplicationHelper

def sign_in(user)
  visit login_path
  fill_in 'email',    with: user.email
  fill_in 'password', with: "foobar"
  click_button 'Войти'
end
