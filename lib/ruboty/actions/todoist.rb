module Ruboty
  module Actions
    class Todoist < Ruboty::Actions::Base
      ITEM_TEMPLATE = <<-'EOS'.strip_heredoc
        id: %{id}
        タイトル: %{content}
        期限: %{date_string}
      EOS

      def call
        resources = todoist
        message.reply(format(resources))
      end

      private

        def todoist
          case message[:action]
          when 'items'
            items
          end
        end

        def items
          result = client.resource_items
          if message[:date] == 'today'
            result.reject! { |_| today?(_) }
          end

          result
        end

        def today?(item)
          return true if item[:due_date].blank?

          due_date = Time.strptime(item[:due_date], "%a %d %b %Y %T")
          now = Time.now
          message.reply(due_date.between?(now.beginning_of_day, now.tomorrow.beginning_of_day))
          return true unless due_date.between?(now.beginning_of_day, now.tomorrow.beginning_of_day)

          false
        end

        def format(resources)
          ''.tap do |_|
            _ << "```"
            _ << "今日までが期限のタスク (#{resources.count}件)"
            _ << "\n"
            resources.each do |resource|
              _ << "===================="
              _ << "\n"
              _ << sprintf(ITEM_TEMPLATE, { id: resource[:id], content: resource[:content], date_string: resource[:date_string]})
              _ << "===================="
              _ << "\n"
            end
            _ << "```"
          end
        end

        def client
          @client ||= Ruboty::Todoist::Client.new
        end
    end
  end
end
