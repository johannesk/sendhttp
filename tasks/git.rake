
class Git

	def initialize
		count= 0
		pwd= "#{ENV["PWD"]}"
		count+= 1 while pwd.sub!(/\//, "")
		git= ".git"
		count2= 0
		until File.exists?(git)
			git= "../#{git}"
			count+= 1
			if count == count2
				raise "git not found"
			end
		end
		@dir= git
	end

	def rev(n= -1)
		File.open("#{@dir}/logs/refs/heads/master").to_a[n].sub(/^[0-9a-f]{40} /, "").sub(/ .*$/, "").strip
	end

end

task :git do
	$git= Git.new
end
