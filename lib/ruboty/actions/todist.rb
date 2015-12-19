module Ruboty
  module Actions
    class Todoist < Ruboty::Actions::Base
      def call
        message.reply('dummy')
      end
    end
  end
end
