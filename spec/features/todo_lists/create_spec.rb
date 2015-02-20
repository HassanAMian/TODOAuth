require 'spec_helper'

describe "Creating todo lists" do
	it "redirects to index page on success" do 
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Foo"
		fill_in "Description", with: "Bar"
		click_button "Create Todo list"

		expect(page).to have_content("Todo list was successfully created")
	end

	it "displays an error when todo list title is missing" do 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: ""
		fill_in "Description", with: "Bar"
		click_button "Create Todo list"
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("FooBar")
	end 

	it "displays an error when todo list title is less than 3 characters" do 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Yo"
		fill_in "Description", with: "Bar"
		click_button "Create Todo list"
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("FooBar")
	end 
end