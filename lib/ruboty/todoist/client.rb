require "open-uri"
require "json"

module Ruboty
  module Todoist
    class Client

      ENDPOINT = "https://todoist.com/API/v6"

      attr_reader :options

      def initialize(options = nil)
        @options = options
      end

      def resource_items
        resorce_all[:Items]
      end

      def resource_projects
        resorce_all[:Projects]
      end

      private

        def endpoint
          ENDPOINT
        end

        def resorce_all
          params = { token: ENV["TODOIST_TOKEN"], seq_no: 0, resource_types: '["all"]' }
          request_url = "#{ENDPOINT}/sync/?#{URI.encode_www_form(params)}"
          puts "request_url: #{request_url}"
          JSON.parse(open(request_url).read, { symbolize_names: true })
        end
    end
  end
end
