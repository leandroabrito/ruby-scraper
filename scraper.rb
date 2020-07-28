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



# def scraper
#   url = "https://blockwork.cc/"
#   unparsed_page = HTTParty.get(url)
#   parsed_page = Nokogiri::HTML(unparsed_page)
#   jobs = []
#   jobs_listing = parsed_page.css('div.listingCard')
#   page = 1
#   per_page = jobs_listing.count
#   total = parsed_page.css('div.job-count').text.split(' ')[1].gsub(',', '').to_i
#   last_page = (total.to_f / per_page.to_f).round
#   while page <= last_page
#     pagination_url = "https://blockwork.cc/listings?page#{page}"
#     pagination_unparsed_page = HTTParty.get(pagination_url)
#     pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
#     pagination_jobs_listing = pagination_parsed_page.css('div.listingCard')
#     pagination_jobs_listing.each do |job_listing|
#       job = {
#         title: job.listing.css('span.job-title').text,
#         company: job_listing.css('span.company').text,
#         location: job_listing.css('span.location').text,
#         url: "https://blockwork.cc" + job_listing.css('a')[0].attributes["href"].value
#       }
#       jobs << job
#     end
#     page ++
#   end
# end
