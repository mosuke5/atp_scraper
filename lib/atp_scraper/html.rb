require 'open-uri'
require 'nokogiri'
module AtpScraper
  # Get and parse html from atpworldtour.com
  class Html
    BASE = "http://www.atpworldtour.com"
    def self.get(uri)
      charset = nil
      html = open(BASE + uri) do |f|
        charset = f.charset
        f.read
      end
      { html: html, charset: charset }
    end

    def self.parse(html, charset)
      Nokogiri::HTML.parse(html, nil, charset)
    end
  end
end
