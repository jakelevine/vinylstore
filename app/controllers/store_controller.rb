#!/bin/env ruby
# encoding: utf-8
class StoreController < ApplicationController

  def storefront
  	#response = User.prepare_access_token(current_user)		
	@response = User.get_rdio(current_user)
	
	@results_array = Array.new

	
	@response.each do |album, details|
		album_name = album
		artist_name = details[0]
		results = User.amazon_lookup(album_name+" "+artist_name)
		if results[0]
			@results_array.push(album => [details[0], details[1], results[0][0]])
		end
		sleep(1)
	end 

  	#render :json => @results_array
  	return @results_array
  	
  
  end
  def search
  	
  	@results = User.amazon_lookup("Era Extraña Neon Indian vinyl")
  	render :json => @results
  end 
end
