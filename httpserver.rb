
class HTTPServer

	def initialize
		@files= []
	end

	def add_file(file)
		@files<< file
	end

	def listen(port)
		@listen= TCPServer.new(nil, port)
		begin
			while connection= @listen.accept_nonblock
			end
		rescue Errno::EAGAIN
			retry
		end
	end

end

