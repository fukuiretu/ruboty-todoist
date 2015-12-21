module Ruboty
  module Handlers
    class Todoist < Base
      ARTICLE_FORMAT = "%{content}  due_date: %{due_date}\n"

      on(
        /todoist items (?<status>uncompleted) (?<date>all|today)/,
        name: "items",
        description: "Todoist items Controller"
      )

      on(
        /todoist projects/,
        name: "projects",
        description: "Todoist projects Controller"
      )

      def items(message)
        Ruboty::Actions::Item.new(message).call
      end

      def projects(message)
        Ruboty::Actions::Project.new(message).call
      end
    end
  end
end
