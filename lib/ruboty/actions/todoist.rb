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
          Ruboty::Todoist::Resorces::Item.fetch_with_filter { |_| _.checked == 0 && _.due_today? }
        end

        def format(resources)
          ''.tap do |_|
            _ << "```"
            _ << "\n"
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
