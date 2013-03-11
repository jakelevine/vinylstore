#!/bin/env ruby
# encoding: utf-8

require "rexml/document" 

class StoreController < ApplicationController
	

  def storefront
  	
	@response = User.get_albums(current_user)
	@results_array = User.get_recs(@response)
	
  	#render :json => @results_array
  	return @results_array
  	
  
  end
  def search
  	
  	#@results = User.amazon_lookup("Era Extraña Neon Indian")
  	@response = User.get_albums(current_user)
  	render :json => @response
  end 

  def show

    @user = User.find_by_shortname(params[:shortname])

    @results_array = Rails.cache.fetch(@user.shortname) {
        @response = User.get_albums(@user)
        @results_array = User.get_recs(@response)
	   }
  	#render :json => @results_array
  	return @results_array

  end

    


end
