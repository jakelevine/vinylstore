
class User < ActiveRecord::Base

	
	require "#{Rails.root}/lib/rdio-simple/rdio"
	require "#{Rails.root}/lib/rdio-simple/om"

	API_KEY = ENV['RDIO_KEY']
	API_SECRET = ENV['RDIO_SECRET']

	AMZN_KEY = ENV['AMZN_KEY']
	AMZN_SECRET = ENV['AMZN_SECRET']
	AMZN_TAG = ENV['AMZN_TAG']

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	    user.key = auth["extra"]["raw_info"]["key"]
	    user.token = auth["credentials"]["token"]
	    user.secret = auth["credentials"]["secret"]
	  	end
	end
	def each
		@items.each {|item| yield item}
	end

	def self.get_rdio(user)
		consumer = OAuth::Consumer.new(API_KEY, API_SECRET, {
			:site => "http://api.rdio.com/"
			})

		access_token = OAuth::AccessToken.new(consumer, user.token, user.secret )

		rdio = Rdio.new(consumer, access_token)
		heavyRotation = rdio.call('getHeavyRotation', {'user' => user.uid, 'type' => 'albums', 'limit' => '20'})["result"]

		albumHash = Hash.new

		heavyRotation.each do |album|
			albumHash[album["name"]]= [album["artist"], album["icon"]]
		end 

		return albumHash
	end

	def self.amazon_lookup(album)
		client = A2z::Client.new(key: AMZN_KEY, secret: AMZN_SECRET, tag: AMZN_TAG)
		response = client.item_search do
             category 'Music'
             keywords ""+album+" vinyl"
             response_group 'ItemAttributes'

           end
        
        vinylArray = Array.new
        response.items.each do |item|
        	if item.binding == "Vinyl"
        		vinylArray.push([ item.detail_page_url, item["title"], item["artist"]]  )
        	end
        end



        return vinylArray

	end 




end
