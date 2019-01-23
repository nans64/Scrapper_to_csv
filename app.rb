# lignes très pratiques qui appellent les gems du Gemfile. On verra plus tard comment s'en servir ;)
require 'bundler'
Bundler.require

# lignes qui appellent les fichiers lib/user.rb et lib/event.rb
# comme ça, tu peux faire User.new dans ce fichier d'application. Top.
$:.unshift File.expand_path("./../lib/app", __FILE__)

require 'scrapper' #plus besoin de préciser le path exact


$:.unshift File.expand_path('./../lib/views', __FILE__)
require 'index'

puts Index.new.perform




