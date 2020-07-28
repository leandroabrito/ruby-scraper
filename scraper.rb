require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  puts 'insert url'
  url = gets.chomp
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  subjects_list = parsed_page.css('div.cur-demo')
  # subjects = []
  subjects_list.each do |subject|
    subject = {
      materia: subject.css('div.cur-demo-title').text.strip
    }
    # subjects << subject
    File.open("subjects.txt", "a") { |f| f.write "#{subject[:materia]}\n" }
  end
end

scraper

