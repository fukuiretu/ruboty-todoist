require "json"

module Ruboty
  module Todoist
    module Resorces
      class Base < Hashie::Dash
        ENDPOINT = 'https://todoist.com/API/v6'

        def self.fetch
          raise NotImplementedError.new("Must implement #{self.class}##{__method__}")
        end

        def self.resorce_all
          response = client.get(
            path: 'sync',
            params: {
              token: token,
              seq_no: 0,
              resource_types: '["all"]'
            }
          )
          JSON.parse(response.body, { symbolize_names: true })
        end

        private

          def self.client
            @client ||= Ruboty::Http::Client.new(endpoint: endpoint)
          end

          def self.endpoint
            ENDPOINT
          end

          def self.token
            ENV["TODOIST_TOKEN"]
          end
      end
    end
  end
end
