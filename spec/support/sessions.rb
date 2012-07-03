def create_users(config)
  @session_to_user_attributes_map ||= {}
  config.each do |session_name, attributes|
    @session_to_user_attributes_map[session_name] = attributes
    create(:user, attributes)
  end
end

def create_sessions
  @session_to_user_attributes_map.each do |name, user_attributes|
    act_as(name) do
      visit new_user_session_path
      fill_in user_attributes[:email] => 'Email',
              user_attributes[:password] => 'Password'
      click 'Sign in'
    end
  end
end