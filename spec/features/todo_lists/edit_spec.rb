require 'spec_helper'

describe "Editing todo lists" do
	let!(:todo_list) { todo_list = TodoList.create(title: "Foo", description: "Bar") }
	def update_todo_list(options={})
		options[:title] ||= "Foo"
		options [:description] ||= "Bar"

		todo_list = options[:todo_list]
		
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end 

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end
	
	it "updates a todo list successfully" do
		update_todo_list todo_list: todo_list, title: "New", description: "New"

		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New")
		expect(todo_list.description).to eq("New")
	end

	it "displays an error with no title" do
		update_todo_list todo_list: todo_list, title: "", description: "New"
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)
		expect(page).to have_content("error")
	end

	it "displays an error with short title" do
		update_todo_list todo_list: todo_list, title: "Yo", description: "New"
		expect(page).to have_content("error")
	end

	it "displays an error with no description" do
		update_todo_list todo_list: todo_list, title: "New", description: ""
		expect(page).to have_content("error")
	end

	it "displays an error with short description" do
		update_todo_list todo_list: todo_list, title: "New", description: "Yo"
		expect(page).to have_content("error")
	end
end
