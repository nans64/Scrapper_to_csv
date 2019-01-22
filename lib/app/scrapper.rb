class Scrapper

attr_accessor :mairie_list

	def initialize

  		@mairie_list = []
	end


	def get_townhall_email(townhall_url)
		 
		@mairie_list = Array.new # Create the Array

		#$url2 = ["http://annuaire-des-mairies.com/95/ableiges.html","http://annuaire-des-mairies.com/95/fosses.html","http://annuaire-des-mairies.com/95/moussy.html"]

		$url.each do |link|
		doc = Nokogiri::HTML(open(link)) # Open the page

		doc.xpath('/html').each do |node| # Loop to collect informations
				@collect_emails = {

					@email = node.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text => # Xpath for email
		  			@city = node.xpath('/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a').text # Xpath for city
				}
				@mairie_list << @collect_emails
				puts "Scrap de #{@collect_emails[@email]} en cours" # Print email
				end

		  end
		puts "J'ai fini de scrapper les #{$amount_links} liens"	#185

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
 
	def save_as_json
		
		json_hash = @mairie_list

		File.open("db/temp.json","w") do |f|
		  f.write(json_hash.to_json)
		end

	end

	def save_as_spreadsheet
	   

	    session = GoogleDrive::Session.from_config("key.json")
	    ws = session.spreadsheet_by_key("1tc5cZjdAQBZEMDLL6IDmcidBCwGQ0_AH-ldP_AlQWu4").worksheets[0]
	    
	    
		ville = "ville"
		email_ville = 
	    
		ville = "ville"
		email_ville = "email"
		ws.insert_rows(1, [[ville, email_ville]])	

	    # Changes content of cells.
	    # Changes are not sent to the server until you call ws.save().
	    i=2
	        @mairie_list.each do |line|
	                line.each do |mairie, mail|
	                ws[i, 1] = mairie
	                ws[i, 2] = mail
	                i+=1
	                ws.save
	                end
	        end
	end

	def save_as_csv
	   csv = File.open("db/emails.csv","wb")
	   @mairie_list.each do |line|
	               line.each do |mairie, mail|
	                   csv.puts ("#{mairie},#{mail}")                
	               end
	   		  end
	end


 end
