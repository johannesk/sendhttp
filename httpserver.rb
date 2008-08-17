#
# © Johannes Krude 2008
#
# This file is part of sendfile-utils.
#
# broadcast-files is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# broadcast-files is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#

require 'sendfile/io2io'
require 'sendfile/magicmime'

class HTTPServer

	def initialize
		#@files= [] FIXME I don't remeber what this was for
	end

	def listen(port, &block)
		@listen= TCPServer.new(nil, port)
		begin
			threads= 0
			while connection= @listen.accept
				threads+= 1
				Thread.new(connection) do |c|
					handle_connection(c, &block)
					threads-= 1
				end
			end
		rescue Errno::EAGAIN
			retry
		rescue Errno::EINVAL
		end
		sleep 0.01 while threads > 0
	end

	def close
		@listen.close_read
	end

	def handle_connection(connection, &block)
		line= connection.readline.strip
		if line=~ /^GET \/(.*?) HTTP\/1.[01]$/ and stream= block.call($1, HTTPServer.read_vars(connection))
			stream= [stream].flatten
			vars= if stream.size == 2
				stream[1]
			else
				Hash.new
			end
			stream= stream[0]
			connection.puts "HTTP/1.1 200 OK"
			connection.puts HTTPServer.header.collect { |name, value| "#{name}: #{value}" }
			connection.puts vars.collect { |name, value| "#{name}: #{value}" }
			connection.puts "Connection: close"
			connection.puts
			case stream
			when IO
				IO2IO.forever(stream.to_i, connection.to_i)
			when String
				connection.write stream
			end
			connection.close
		else
			connection.puts("HTTP/1.1 400 Bad Request")
			connection.puts HTTPServer.header.collect { |name, value| "#{name}: #{value}" }
			connection.puts
			connection.close
		end
	end

	def HTTPServer.header
		result= Hash.new
		result["Date"]= "Date: #{Time.now.gmtime.strftime("%a, %d %b %Y %H:%M:%S GMT")}"
		result["Server"]= "sendhttp/#{$version}"
		return result
	end

	def HTTPServer.read_vars(stream)
		result= Hash.new
		while stream.readline.strip=~ /^([^:]+):(.*)$/
			result[$1]= $2.strip
		end
		result
	end
	
	def HTTPServer.put_file(filename)
		vars= Hash.new
		vars["Content-Type"]= MagicMime.file(filename)
		vars["Content-Length"]= File.size(filename)
		return [File.open(filename), vars]
	end

end

