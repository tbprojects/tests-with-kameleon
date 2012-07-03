require 'spec_helper'

describe 'Application' do
  before(:all) do
    create_users({
      :stewie => {:email => 'stewie.griffin@example.com', :password => 'secret'},
      :chris => {:email => 'chris.griffin@example.com', :password => 'secret'},
      :peter => {:email => 'peter.griffin@example.com', :password => 'secret'}
    })
  end

  before(:each) { create_sessions }

  it 'allows users to complete project with many tasks' do
    # creating project
    act_as(:stewie) do
      click 'Projects', 'New project'
      fill_in 'Ruby Project' => 'Name',
              :check => 'Active'
      click 'Create Project'
      see 'Project created!', 'Ruby Project'
    end

    # creating task
    act_as(:stewie) do
      click 'Projects', 'Ruby Project', 'New task'
      fill_in 'Setup test env' => 'Name',
              'Use kameleon with rspec' => 'Description',
              :select => { 'chris.griffin@example.com' => 'User'},
              :choose => 'High'
      click 'Create Task'
      see 'Task created!'
      within('table') do
        see 'Setup test env', 'New'
      end
    end

    # update task
    act_as(:chris) do
      visit root_path
      click 'Setup test env'
      see 'Status: New', 'Progress: 0%', 'Use kameleon'
      click 'Edit task'
      fill_in 'I have installed rspec, spork, capybara and kameleon. Please review configuration.' => 'Comment',
              :select => { 'peter.griffin@example.com' => 'User', '50%' => 'Progress', 'Opened' => 'Status'}
      click 'Update Task'
      see 'Task updated!'
      within('table') do
        see 'Setup test env', 'Opened'
      end
    end

    # update task #2
    act_as(:peter) do
      visit root_path
      click 'Setup test env'
      see 'Status: Opened', 'Progress: 50%', 'Use kameleon', 'I have installed rspec'
      click 'Edit task'
      fill_in 'It is correct. I am closing this task' => 'Comment',
              :select => { 'stewie.griffin@example.com' => 'User', '100%' => 'Progress', 'Closed' => 'Status'}
      click 'Update Task'
      see 'Task updated!'
      within('table') do
        see 'Setup test env', 'Closed'
      end
    end

    # remove task, update project, remove project
    act_as(:stewie) do
      visit root_path
      click 'Projects', 'Ruby Project', 'Setup test env'
      click :and_accept => 'Remove task'
      see 'Task destroyed!'
      not_see 'Setup test env'
      click 'Edit project'
      fill_in 'PROJECT TO DESTROY' => 'Name',
              :uncheck => 'Active'
      click 'Update Project'
      see 'Project updated!'
      click 'PROJECT TO DESTROY'
      click :and_accept => 'Remove project'
      see 'Project destroyed!'
      not_see 'PROJECT TO DESTROY'
    end

  end
end