module Ruboty
  module Handlers
    class Todoist < Base
      ARTICLE_FORMAT = "%{content}  due_date: %{due_date}\n"

      on /todoist (?<action>items) (?<status>uncompleted) (?<date>all|today)/,
      name: "todoist",
      description: "Todoist items Controller"

      def todoist(message)
        Ruboty::Actions::Todoist.new(message).call
      end
    end
  end
end
