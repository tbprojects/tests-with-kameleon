OPENED_SESSION_NAMES = []

def create_users_and_sessions(config)
  config.each do |name, attributes|
    create(:user, attributes)
    act_as(name) do
      visit_dashboard
      fill_in attributes[:email] => 'Email', attributes[:password] => 'Password'
      click 'Sign in'
    end
    OPENED_SESSION_NAMES.push(name)
  end
end

def redirect_users_to_root_path
  OPENED_SESSION_NAMES.each do |name|
    act_as(name) { visit_dashboard }
  end
end

def visit_dashboard
  visit root_path
end