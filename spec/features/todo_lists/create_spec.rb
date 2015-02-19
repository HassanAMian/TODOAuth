require 'spec_helper'

describe "Creating todo lists" do
	it "redirects to index page on success" do 
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
	end 
end