require "open-uri"
require "pp"
require "json"
require 'time'
require 'dotenv'
Dotenv.load

API_URL = "https://todoist.com/API/v6"

# params = { token: TOKEN }
# request_url = "#{API_URL}/get_all_completed_items?#{URI.encode_www_form(params)}"
params = { token: ENV["TODOIST_TOKEN"], seq_no: 0, resource_types: '["all"]' }
request_url = "#{API_URL}/sync/?#{URI.encode_www_form(params)}"
res = open(request_url)
code, message = res.status

pp code
pp message

result = JSON.parse(res.read)

result["Items"].each do |item|
  # プロジェクト指定
  if item["project_id"] == 144157733
    pp item
    pp Time.strptime(item["due_date"], "%a %d %b %Y %T") unless item["due_date"].nil?
    # 今日のタスク
    # if true
    # end
  end
end

# result["Projects"].each do |item|
#   pp item
# end
