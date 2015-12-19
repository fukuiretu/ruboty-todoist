require_relative "../lib/ruboty/todoist"
require "pp"
require 'dotenv'
Dotenv.load

client = Ruboty::Todoist::Client.new
pp client.resource_items
