$:.unshift File.expand_path('./../lib/app', __FILE__)
require 'scrapper'
$:.unshift File.expand_path('./../lib/views', __FILE__)
require 'done'

class Index


	def choice

		puts "Choisissez le format de vos données à scrapper :"
		puts " 1 - format JSON"
		puts " 2 - format Google Spreadsheet"
		puts " 3 - format CSV"
		puts " 4 - DONE !"
		print "Entez votre choix ici : "

		# Get the choice

		choice = gets.chomp.to_i

		return choice

	end


	def get_data(choice)

		# New instance

		instance = Scrapper.new

		# Get all data into a table

		instance.get_townhall_urls

		# En fonction du choix, je convertis en : 

			if choice == 1 then # JSON

				instance.save_as_json
				#puts Index.new.perform
				puts Done.new.perform
			elsif choice == 2 then # SPREADSHEET

				instance.save_as_spreadsheet
				#puts Index.new.perform
				puts Done.new.perform
			elsif choice == 3 then # CSV

				instance.save_as_csv
				#puts Index.new.perform
				puts Done.new.perform		
			end
	end




	def perform

		get_data(choice)

	end


end