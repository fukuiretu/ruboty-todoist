module Ruboty
  module Todoist
    module Resorces
      class Project < Base
        property :user_id
        property :name
        property :color
        property :is_deleted
        property :collapsed
        property :inbox_project
        property :archived_date
        property :item_order
        property :indent
        property :archived_timestamp
        property :id
        property :shared
        property :is_archived

        def self.fetch
          projects = resorce_all[:Projects]
          return [] if projects.blank?

          projects.map { |_| Ruboty::Todoist::Resorces::Project.new(_) }
        end

        def self.fetch_with_filter
          fetch.select { |_| yield(_) }
        end
      end
    end
  end
end
