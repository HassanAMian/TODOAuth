require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(options={})
		options[:title] ||= "Foo"
		options [:description] ||= "Bar"
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to index page on success" do 
		create_todo_list

		expect(page).to have_content("Todo list was successfully created")
	end

	it "displays an error when todo list title is missing" do 
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("FooBar")
	end 

	it "displays an error when todo list title is less than 3 characters" do 
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Yo"
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("FooBar")
	end 

	it "displays an error when todo list description is missing" do 
		expect(TodoList.count).to eq(0)

		create_todo_list description: ""
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("FooBar")
	end 

	it "displays an error when todo list description is less than 3 characters" do 
		expect(TodoList.count).to eq(0)

		create_todo_list description: "Yo"
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("FooBar")
	end 
end