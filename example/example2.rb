require_relative "../lib/ruboty/todoist"
require "pp"
require 'dotenv'
Dotenv.load

# items = Ruboty::Todoist::Resorces::Item.fetch
# items.each { |_| pp _.due_date }

projects = Ruboty::Todoist::Resorces::Project.fetch
pp projects
