module Ruboty
  module Actions
    class Item < Ruboty::Actions::Base
      ITEM_TEMPLATE = <<-'EOS'.strip_heredoc
        id: %{id}
        タイトル: %{content}
        期限: %{date_string}
      EOS

      def call
        message.reply(format(items))
      end

      private

        def items
          case message[:status].to_sym
          when :uncompleted
            case message[:date].to_sym
            when :today
              Ruboty::Todoist::Resorces::Item.fetch_with_filter { |_| _.checked.to_b == false && _.due_today? }
            end
          end
        end

        def projects
          Ruboty::Todoist::Resorces::Project.fetch
        end

        def format(resources)
          ''.tap do |_|
            _ << "```"
            _ << "\n"
            _ << "今日までが期限のタスク (#{resources.count}件)"
            _ << "\n"
            resources.each do |resource|
              _ << "//-----------------------------"
              _ << "\n"
              _ << sprintf(ITEM_TEMPLATE, { id: resource.id, content: resource.content, date_string: resource.date_string})
              _ << "\n"
            end
            _ << "```"
          end
        end
    end
  end
end
