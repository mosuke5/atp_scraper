module AtpScraper
  module Activities
    # Activity Record Class
    class Record
      def initialize(doc)
        @record = doc
      end

      def get
        result = {}
        @record.css("td").each_with_index do |td, n|
          record_content = td.content.strip
          case n
          when 0 then
            result[:round] = record_content
          when 1 then
            result[:opponent_rank] = record_content
          when 2 then
            result[:opponent_name] = record_content
          when 3 then
            result[:win_loss] = record_content
          when 4 then
            result[:score] = record_content
          end
        end
        result
      end
    end
  end
end
