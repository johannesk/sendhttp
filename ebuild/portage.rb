#!/bin/env ruby

class Portage

	attr_reader :dir

	def Portage.overlay
		if File.open("/etc/make.conf").to_a.find { |line| line=~ /^PORTDIR_OVERLAY="(.*)"$/ }
			Portage.new($1)
		else
			nil
		end
	end

	def initialize(dir)
		@dir= dir
	end

	def mkdir(dir)
		Dir.mkdir(@dir+"/"+dir) unless File.exists?(@dir+"/"+dir)
	end

	def add_file(dir, type, file)
		case type
		when :ebuild
			path= @dir+"/"+dir+"/"+file
		when :dist
			path= "/usr/portage/distfiles/"+file
		end
		File.open(@dir+"/"+dir+"/Manifest", "a").write("#{type.to_s.upcase} #{file} #{File.size(path)} SHA256 #{`sha256sum #{path}`.sub(/ .*$/, "")}")
	end

end
