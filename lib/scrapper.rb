require 'open-uri'
require 'nokogiri'
require 'byebug'

class Scrapper

	def get_townhall_email(townhall_url)
		 
		@mairie_list = Array.new # Create the Array

		#$url2 = ["http://annuaire-des-mairies.com/95/ableiges.html","http://annuaire-des-mairies.com/95/fosses.html","http://annuaire-des-mairies.com/95/moussy.html"]

		$url.each do |link|
		doc = Nokogiri::HTML(open(link)) # Open the page

		doc.xpath('/html').each do |node| # Loop to collect informations
				@collect_emails = {
					 email: @email = node.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text, # Xpath for email
		  			 city: @city = node.xpath('/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a').text # Xpath for city
				}
				@mairie_list << @collect_emails
				puts "Scrap de #{@collect_emails[@email]} en cours" # Print email
				end

		  end
		save_as_JSON 
		puts "J'ai fini de scrapper les #{$amount_links} liens"	#185
	   	return @mairie_list

	end	


	def get_townhall_urls

		doc2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
			doc2.css('html').each do |node|
			$url = doc2.css('a.lientxt').map { |link| "http://annuaire-des-mairies.com" + link['href'].delete_prefix(".") } # Reformat the URL

			puts "j'ai fini de récupérer les liens"
			$amount_links = $url.count # Count the number of link

			end 

		get_townhall_email($url)

	end
 
	def save_as_JSON
		
		tempHash = {
	    "@collect_emails[@email]" => "email_a",
	    "@collect_emails[@city]" => "city_a"


		}
		tempHash = @mairie_list

		File.open("temp.json","w") do |f|
		  f.write(tempHash.to_json)
		end

	end
	
	def perform

		get_townhall_urls

	end

 end
