module Ruboty
  module Handlers
    class Todoist < Base
      ARTICLE_FORMAT = "%{content}  due_date: %{due_date}\n"

      on /todoist( me)? (?<action>show) (?<status>uncompleted) (?<date>all|today)/,
      name: "todoist",
      description: "Todoist Controller"

      def todoist(message)
        Ruboty::Actions::Todist.new(message).call
      end
    end
  end
end
