module Ruboty
  module Actions
    class Project < Ruboty::Actions::Base
      PROJECT_TEMPLATE = <<-'EOS'.strip_heredoc
        id: %{id}
        プロジェクト名: %{name}
      EOS

      def call
        message.reply(format(projects))
      end

      private

        def projects
          Ruboty::Todoist::Resorces::Project.fetch
        end

        def format(resources)
          ''.tap do |_|
            _ << "```"
            _ << "\n"
            _ << "プロジェクト (#{resources.count}件)"
            _ << "\n"
            resources.each do |resource|
              _ << "//-----------------------------"
              _ << "\n"
              _ << sprintf(PROJECT_TEMPLATE, { id: resource.id, name: resource.name })
              _ << "\n"
            end
            _ << "```"
          end
        end
    end
  end
end
