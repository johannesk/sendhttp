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

$version="pre 0.1α"

$: << "./lib"
require 'optparse'
require 'pathname'

$verbose= 1

begin
	arghandler= OptionParser.new
	
#	arghandler.banner= "Usage: bget [options] CATEGORY/FILE"

	arghandler.on("-h", "--help", "display this message") do
		STDOUT.puts arghandler
		exit 0
	end

	arghandler.on("-n FILENAME", "--name FILENAME", "advertise file as FILENAME") do |filename|
		$filename= filename
	end

	$port= 12345
	arghandler.on("-p PORT", "--port PORT", Integer, "Listen on port PORT") do |port|
		$port= port.to_i
	end

	$timeout= 1.0/0 #Infinity
	arghandler.on("-t SECONDS", "--timeout SECONDS", Float, "wait SECONDS for a request") do |timeout|
		$timeout= timeout
	end

	arghandler.on("-v", "--version", "display the version number") do
		STDOUT.puts $version
		exit 0
	end

	args= arghandler.parse(ARGV)
	$file= args.shift
	if $file
		unless File.exists? $file
			STDERR.puts "File '#{$file}' does not exist"
			exit 1
		end
		$filename= Pathname.new($file).basename.to_s unless $filename
	else
		unless $filename
			STDERR.puts "No filename given"
			exit 1
		end
	end

	source= File.open($file)
	$network_module.do(source, $filename, $port)

rescue OptionParser::MissingArgument => e
	STDERR.puts "Missing argument for '#{e.args}'"
	exit 1
rescue OptionParser::InvalidOption => e
	STDERR.puts "Undefined Option '#{e.args}'"
	exit 1
rescue OptionParser::InvalidArgument => e
	STDERR.puts "Invalid argument for '#{e.args}'"
	exit 1
rescue SignalException => e
	STDERR.puts "#{e} aborted"
rescue Interrupt
	STDERR.puts "aborted"
end

