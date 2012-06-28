def create_users_and_sessions(config)
  config.each do |name, attributes|
    create(:user, attributes)
    act_as(name) do
      visit new_user_session_path
      fill_in attributes[:email] => 'Email',
              attributes[:password] => 'Password'
      click 'Sign in'
    end
  end
end