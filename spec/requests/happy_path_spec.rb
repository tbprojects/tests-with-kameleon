require 'spec_helper'

describe 'Happy path' do
  before(:all) do
    create_users_and_sessions({
      :stewie => {:email => 'stewie.griffin@example.com', :password => 'secret'},
      :chris => {:email => 'chris.griffin@example.com', :password => 'secret'},
      :peter => {:email => 'peter.griffin@example.com', :password => 'secret'}
    })
  end

  def create_project
    click 'Projects', 'New project'
    fill_in 'Ruby Project' => 'Name'
    fill_in :check => 'Active'
    click 'Create Project'
  end

  def create_task
    click 'Projects', 'Ruby Project', 'New task'
    fill_in 'Setup test env' => 'Name', 'Use kameleon with rspec' => 'Description'
    fill_in :select => { 'chris.griffin@example.com' => 'User'}
    fill_in :choose => 'High'
    click 'Create Task'
  end

  it 'works' do
    act_as(:stewie) do
      create_project
      see 'Project created!'
    end

    act_as(:stewie) do
      create_task
      see 'Task created!'
    end

    act_as(:chris) do
      visit_dashboard
      see 'Setup test env'
    end

    act_as(:peter) do
      visit_dashboard
      not_see 'Setup test env'
    end

  end
end