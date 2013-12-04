$: << File.dirname(__FILE__) + "/scrabble"
require 'sinatra'
require 'rubygems'
require 'scrabble'
require 'pry'

get '/' do
  erb :index
end

get '/words' do
  new_rack_tiles = Scrabble.new(params[:tile])
  @total = new_rack_tiles.solve_total
  @solve = new_rack_tiles.solve  
  erb :words
end