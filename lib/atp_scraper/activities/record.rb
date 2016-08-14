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
            result[:score] = convert_score(record_content)
          end
        end
        result
      end

      private

      # "62 765" -> "62 76(5)"
      # "768 64 46 46 76-74" -> "76(8) 64 46 46 76-74"
      def convert_score(score)
        result = []
        score.split("\s").each do |s|
          # Str starts '76' or '67' (not '76-' or '67-')
          if (a = s.slice!(/^(76|67)(?!-)/))
            result.push("#{a}(#{s})")
          else
            result.push(s)
          end
        end
        result.join("\s")
      end
    end
  end
end
