require 'spec_helper'

describe "Editing todo lists" do
	todo_list = TodoList.create(title: "Foo", description: "Bar")
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end 
		fill_in "Title", with: "New"
		fill_in "Description", with: "New"
		click_button "Update Todo list"

		todo_list.reload

		expect(page).to have_content("Todo list was successfully created")
		expect(todo_list.tite).to eq("New")
		expect(todo_list.description).to eq("New")
end