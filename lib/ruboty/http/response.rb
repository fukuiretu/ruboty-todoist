module Ruboty
  module Http
    class Response
      def initialize(faraday_response)
        @raw_body = faraday_response.body
        @raw_headers = faraday_response.headers
        @raw_status = faraday_response.status
      end

      def body
        @raw_body
      end

      def headers
        @raw_headers.inject({}) do |result, (k, v)|
          result.merge(k.split("-").map(&:capitalize).join("-") => v)
        end
      end

      def status
        @raw_status
      end

      def more_than_400?
        @raw_status >= 400
      end
    end
  end
end
