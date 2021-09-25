#!/usr/local/bin/ruby

require 'nokogiri'
require 'open-uri'

puts "Insert url: "
url = gets.chomp

puts "Cantidad de paginas: "
cantidadDveces = gets.to_i

parrafos = []

  cantidadDveces.times do |i|
    puts "Página #{i+1} de #{cantidadDveces}"
    document = Nokogiri::HTML(open(url))
    File.write("libro.txt", document.xpath( "//h1" ).text, mode: "a")
    File.write("libro.txt", "\n\n", mode: "a")

    div_main = document.css('div.entry-content')
    
    div_main.css('p').each do |post|
      parrafos << post.text
    end 

    # Delete comments and white space
    parrafos.delete_at(0)
    parrafos.pop
    parrafos.pop
    parrafos.pop
    parrafos.pop
    parrafos.pop

    # Printing text from each <p>
    parrafos.each do |tpar|
      File.write("libro.txt", tpar, mode: "a")
      File.write("libro.txt", "\n", mode: "a")
    end 

    File.write("libro.txt", "\n\n\n\n", mode: "a")

    parrafos.clear

    url = document.css('div.wp-post-navigation-next a').attr('href')
  end
 