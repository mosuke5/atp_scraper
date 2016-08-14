module AtpScraper
  # Utility class
  class Utility
    # "62 765" -> "62 76(5)"
    # "768 64 46 46 76-74" -> "76(8) 64 46 46 76-74"
    # "76 63" -> "76 64"
    def self.convert_score(score)
      result = []
      score.split("\s").each do |s|
        # Str starts '76' or '67' (not '76-' or '67-')
        if (a = s.slice!(/^(76|67)(?!-|$)/))
          result.push("#{a}(#{s})")
        else
          result.push(s)
        end
      end
      result.join("\s")
    end
  end
end
