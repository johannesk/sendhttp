
desc "create the tarball"
file "sendhttp.tar.gz" => ".git/refs/heads/master" do
	`git archive --format=tar master | gzip > sendhttp.tar.gz`
end

desc "place the tarball into /usr/portage/distfiles/"
task :distfile => "sendhttp.tar.gz" do
	rev= File.open(".git/refs/heads/master").read.strip
	`cp sendhttp.tar.gz /usr/portage/distfiles/sendhttp-#{rev}.tar.gz`
end
