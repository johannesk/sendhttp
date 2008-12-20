
desc "create the ebuild in the OVERLAY"
task :ebuild => [:distfile, ".git/refs/heads/master"] do
	$time= Time.now unless $time
	require 'erb'
	require 'tasks/portage'
	portage= Portage.overlay
	unless portage
		raise "Could not find overlay"
	end
	rev= File.open(".git/refs/heads/master").read.strip
	portage.mkdir("net-misc/sendhttp")
	file= File.open("#{portage.dir}/net-misc/sendhttp/sendhttp-#{$time.to_i}.ebuild", "w")
	file.write(ERB.new(File.open("tasks/ebuild.eruby", "r").read).result(binding))
	file.close
	portage.add_file("net-misc/sendhttp", :ebuild, "sendhttp-#{$time.to_i}.ebuild")
	portage.add_file("net-misc/sendhttp", :dist, "sendhttp-#{$time.to_i}.tar.gz")
end
