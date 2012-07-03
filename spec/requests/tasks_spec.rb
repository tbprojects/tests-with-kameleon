require 'spec_helper'

describe 'Task' do
  before(:all) do
    create_users({
      :stewie => {:email => 'stewie.griffin@example.com', :password => 'secret'},
      :chris => {:email => 'chris.griffin@example.com', :password => 'secret'},
      :peter => {:email => 'peter.griffin@example.com', :password => 'secret'}
    })
    @project = Project.create :name => 'Some project', :manager => User.find_by_email('stewie.griffin@example.com')
    @task = @project.tasks.create :name => 'Testing task', :user => User.find_by_email('chris.griffin@example.com')
  end

  before(:each) { create_sessions }

  it 'should be displayed in delegated list for assigned user' do
    act_as(:stewie) do
      visit root_path
      not_see 'Testing task'
    end
    act_as(:chris) do
      visit root_path
      see 'Testing task'
    end
  end

  it 'must have a uniq name and assigned user' do
    act_as(:stewie) do
      visit root_path
      click 'Project', 'Some project', 'New task', 'Create Task'
      within('#task_name_input') { see 'can\'t be blank' }
      within('#task_user_input') { see 'can\'t be blank' }
    end
  end

  it 'should be editable only for project manager or assigned user' do
    act_as(:stewie) do
      visit edit_project_task_path(@project, @task)
      not_see 'Access denied'
    end
    act_as(:chris) do
      visit edit_project_task_path(@project, @task)
      not_see 'Access denied'
    end
    act_as(:peter) do
      visit edit_project_task_path(@project, @task)
      see 'Access denied'
    end
  end
end
