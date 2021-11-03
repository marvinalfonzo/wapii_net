class UsersController < ApplicationController
  	require "open-uri" # Allows us to send GET requests and receive the response
	require "json" # Allows us to parse the reponse into a JSON object/hash
    require 'will_paginate/array'

	#before_action :get_users

	def get_users   


        response = open("https://jsonplaceholder.typicode.com/users").read
		@users = JSON.parse(response)

		logger.debug @users.inspect 
        
    end

    def principal
    end

    def index
    	response = open("https://jsonplaceholder.typicode.com/posts").read
    	@comments = JSON.parse(response)
    	#dado una publicacion obtengo todos sus comentarios
    	#https://jsonplaceholder.typicode.com/posts/10/comments
    	@counts_usu = @comments.group_by{|i| i["userId"]}.map{|k,v| 
    		response = open("https://jsonplaceholder.typicode.com/users/#{k}").read
    		@user = JSON.parse(response)
    		[@user["name"], v.count] 
    	}
    end

    def get_all_post(id)
    	response = open("https://jsonplaceholder.typicode.com/posts").read
    	@users = JSON.parse(response)
    end

    def trending
    	
    	response = open("https://jsonplaceholder.typicode.com/comments").read
    	@comments = JSON.parse(response)
  
		@counts_t = @comments.group_by{|i| i["postId"]}.map{|k,v| 
			response = open("https://jsonplaceholder.typicode.com/posts/#{k}").read
    		@post = JSON.parse(response)
    		response = open("https://jsonplaceholder.typicode.com/users/#{@post["userId"]}").read
    		@user = JSON.parse(response)
			[[@post["title"], @post["body"],@user["name"]], v.count] }
            @counts_t=@counts_t.sort { |a|  a[1] }

            @counts_t=@counts_t.paginate(page: 1, per_page: 10)

    end

    def influencer
    	response = open("https://jsonplaceholder.typicode.com/posts").read
    	@comments = JSON.parse(response)
    	#dado una publicacion obtengo todos sus comentarios
    	#https://jsonplaceholder.typicode.com/posts/10/comments
    	@counts_a = @comments.group_by{|i| i["userId"]}.map{|k,v| 
    		response = open("https://jsonplaceholder.typicode.com/users/#{k}").read
    		@user = JSON.parse(response)
    		[@user["name"], v.count] }
    end
end
