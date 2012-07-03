require 'spec_helper'

describe 'Project' do
  before(:all) do
    create_users({
      :stewie => {:email => 'stewie.griffin@example.com', :password => 'secret'},
      :chris => {:email => 'chris.griffin@example.com', :password => 'secret'}
    })
    @project = Project.create :name => 'Some project', :manager => User.find_by_email('stewie.griffin@example.com')
  end

  before(:each) { create_sessions }

  it 'should be displayed in managed list for its creator' do
    act_as(:stewie) do
      visit root_path
      see 'Some project'
    end
    act_as(:chris) do
      visit root_path
      not_see 'Some project'
    end
  end

  it 'must have a name and user assigned' do
    act_as(:stewie) do
      visit root_path
      click 'Project', 'New project', 'Create Project'
      within('#project_name_input') { see 'can\'t be blank' }
    end
  end

  it 'should be editable only for project manager' do
    act_as(:stewie) do
      visit edit_project_path(@project)
      not_see 'Access denied'
    end
    act_as(:chris) do
      visit edit_project_path(@project)
      see 'Access denied'
    end
  end
end
