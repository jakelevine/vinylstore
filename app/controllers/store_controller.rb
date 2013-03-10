#!/bin/env ruby
# encoding: utf-8

require "rexml/document" 

class StoreController < ApplicationController
	

  def storefront
  	
	@response = User.get_albums(current_user)
	
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
  	
  	#@results = User.amazon_lookup("Era Extraña Neon Indian")
  	@response = User.get_albums_test("s2466093", "epkxvjaqptmgn752e5m7xjxadkxk4d5x4cze53zhdj2u873tmszwxwdj6aycgtap", "keuhnGyX4pjs")
  	#render :json => @response
  end 

  def show
    @user = User.find(params[:key])
    render :json => @user
  end

    


end
