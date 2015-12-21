module Ruboty
  module Todoist
    module Resorces
      class Item < Base
        property :due_date
        property :day_order
        property :assigned_by_uid
        property :due_date_utc
        property :is_archived
        property :labels
        property :sync_id
        property :in_history
        property :date_added
        property :checked
        property :date_lang
        property :id
        property :content
        property :indent
        property :user_id
        property :is_deleted
        property :priority
        property :item_order
        property :responsible_uid
        property :project_id
        property :collapsed
        property :date_string

        def due_today?
          return false if self.due_date.blank?

          due_date = Time.strptime(self.due_date, "%a %d %b %Y %T")
          now = Time.now
          return true if due_date.between?(now.beginning_of_day, now.tomorrow.beginning_of_day)

          false
        end

        def self.fetch
          items = resorce_all[:Items]
          return [] if items.blank?

          items.map { |_| Ruboty::Todoist::Resorces::Item.new(_) }
        end

        def self.fetch_with_filter
          fetch.select { |_| yield(_) }
        end
      end
    end
  end
end
