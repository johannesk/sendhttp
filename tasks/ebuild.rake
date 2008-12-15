
desc "create the ebuild in the OVERLAY"
task :ebuild => [:distfile, ".git/refs/heads/master"] do
	require 'erb'
	require 'tasks/portage'
	portage= Portage.overlay
	unless portage
		raise "Could not find overlay"
	end
	time= Time.now.to_i
	rev= File.open(".git/refs/heads/master").read.strip
	portage.mkdir("net-misc/sendhttp")
	file= File.open("#{portage.dir}/net-misc/sendhttp/sendhttp-#{time}.ebuild", "w")
	file.write(ERB.new(File.open("tasks/ebuild.eruby", "r").read).result(binding))
	file.close
	portage.add_file("net-misc/sendhttp", :ebuild, "sendhttp-#{time}.ebuild")
	portage.add_file("net-misc/sendhttp", :dist, "sendhttp-#{rev}.tar.gz")
end
