module Activities
  # Activity Record Class
  class Record
    def self.pickup_record(record_doc)
      result = {}
      record_doc.css("td").each_with_index do |td, n|
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
