class PostsController < ApplicationController
	require "open-uri" # Allows us to send GET requests and receive the response
	require "json" # Allows us to parse the reponse into a JSON object/hash

	#before_action :get_posts

	def get_posts


        response = open("https://jsonplaceholder.typicode.com/posts").read
		@users = JSON.parse(response)

		logger.debug @users.inspect 
        
    end

    def index
    	response = open("https://jsonplaceholder.typicode.com/posts").read
    	@posts = JSON.parse(response)
    	#dado una publicacion obtengo todos sus comentarios
    	#https://jsonplaceholder.typicode.com/posts/10/comments
    	@counts_pos = @posts.map{|k,v| 
    		response = open("https://jsonplaceholder.typicode.com/posts/#{k['id']}").read
    		@post = JSON.parse(response)
    		response = open("https://jsonplaceholder.typicode.com/posts/#{k['id']}/comments").read
    		@comments = JSON.parse(response)
    		response = open("https://jsonplaceholder.typicode.com/users/#{@post["userId"]}").read
    		@user = JSON.parse(response)
    		[[@user["name"],@post["title"], @post["body"]],@comments.count] 
    	}
    end

end
