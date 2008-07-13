
class HTTPServer

	def initialize
		@files= []
	end

	def listen(port, &block)
		@listen= TCPServer.new(nil, port)
		begin
			while connection= @listen.accept
				Thread.new(connection) do |c|
					handle_connection(c, block)
				end
			end
		rescue Errno::EAGAIN
			retry
		end
	end

	def handle_connection(connection, &block)
		line= connection.readline.strip
		if line=~ /^GET \/(.*?) HTTP\/1.[01]$/ and stream= block.call($1)
		else
			connection.write(header("400 Bad Request"))
		end
	end

end

