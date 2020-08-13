module Iiko

require 'net/http'
require 'uri'
require 'digest/sha1'
require 'json'

 
 class IikoRequests
	@@iikoResponseToken
	$a = 999
	def print
		puts "#$a"
	end
	def initialization(login = 'admin',password = 'Cnhtc101%')
		@login=login
		@password=Digest::SHA1.hexdigest password
		@url = URI.parse("http://localhost:8080/resto/api/auth")
		
		#puts "login = #{@login}\npassword = #{@password}"
	end
	
	def GetToken()
	
		if File.exist?("token.txt")
			File.open("token.txt","r") do |log|
				@@iikoResponseToken = log.read
			end
		else
		  initialization()
		  params = {
			'login':@login,
			'pass':@password
			}
			url = @url+"auth"
			url.query = URI.encode_www_form( params )	
		
			@@iikoResponseToken = Net::HTTP.get(url).to_s
			
			File.open("log.txt","a") do |log|
				log.print("Токен получен : #{@@iikoResponseToken}\n")
			end
			File.open("token.txt","w") do |log|
				log.print("#{@@iikoResponseToken}")
			end
			
			
		end
		puts @@iikoResponseToken
	end
	
	def Finalize()
		
		if File.exist?("token.txt")
			File.delete("token.txt")
			params = {
				'key':@@iikoResponseToken		
			}
			url = @url + "logout"
			url.query = URI.encode_www_form( params )	
			Net::HTTP.get(url)
			
			File.open("log.txt","a") do |log|
				log.print("Токен удален : #{@@iikoResponseToken}\n")	
			end			
		end
	end
	
	def IikoPostRequest()
	
		lines=""
		File.open("POST.json") do |jsons|
			lines = JSON.load(jsons)
			
		end

		url = URI("http://localhost:8080/resto/api/v2/reports/olap")
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Post.new(url)
		request["Content-Type"] = "application/json"
		request["Cookie"] = "key=#{@@iikoResponseToken}"
		request.body = lines.to_json	
		response = http.request(request)
		@data = JSON.parse(response.read_body)		
		return @data
	
	end	
	
	def IikoPostRequestForBuzz()
	
		lines=""
		File.open("POSTforBUZZ.json") do |jsons|
			lines = JSON.load(jsons)
			
		end

		url = URI("http://localhost:8080/resto/api/v2/reports/olap")
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Post.new(url)
		request["Content-Type"] = "application/json"
		request["Cookie"] = "key=#{@@iikoResponseToken}"
		request.body = lines.to_json	
		response = http.request(request)
		@data = JSON.parse(response.read_body)		
		return @data
	
	end	
 
	def IikoPostRequestForSebesToday()
	
		lines=""
		File.open("PostForSebesToday.json") do |jsons|
			lines = JSON.load(jsons)
		end
		
		lines['filters']['OpenDate.Typed']['from'] = "2019-06-20"#Date.today.strftime("%Y-%m-%d")
		lines['filters']['OpenDate.Typed']['to'] = "2019-06-21"#Date.today.prev_day.strftime("%Y-%m-%d")
		#puts "keka",Date.today.strftime("%Y-%m-%d")
		#puts lines
		
		url = URI("http://localhost:8080/resto/api/v2/reports/olap")
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Post.new(url)
		request["Content-Type"] = "application/json"
		request["Cookie"] = "key=#{@@iikoResponseToken}"
		request.body = lines.to_json	
		response = http.request(request)
		@data = JSON.parse(response.read_body)		
		return @data
	
	end	

	def IikoPostRequestForSebesMounth()
	
		lines=""
		File.open("PostForSebesMounth.json") do |jsons|
			lines = JSON.load(jsons)
		end
		
		lines['filters']['OpenDate.Typed']['from'] = "2019-06-20"#Date.today.strftime("%Y-%m-%d")
		lines['filters']['OpenDate.Typed']['to']   = "2019-06-21"#Date.today.prev_day.strftime("%Y-%m-%d")
		#puts "keka",Date.today.strftime("%Y-%m-%d")
		
		url = URI("http://localhost:8080/resto/api/v2/reports/olap")
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Post.new(url)
		request["Content-Type"] = "application/json"
		request["Cookie"] = "key=#{@@iikoResponseToken}"
		request.body = lines.to_json	
		response = http.request(request)
		@data = JSON.parse(response.read_body)		
		return @data
	
	end

end

end