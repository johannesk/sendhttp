
files= [
	"Makefile.eruby",
	"Rakefile",
	"configure",
	"html.rb",
	"httpserver.rb",
	"io2io.so",
	"io2io/configure",
	"io2io/io2io.c",
	"license.txt",
	"magicmime.so",
	"magicmime/configure",
	"magicmime/magicmime.c",
	"sendhttp",
	"tasks"
]

desc "create the tarball"
file "sendhttp.tar.gz" => files do
	`tar -czf sendhttp.tar.gz #{files.join(" ")}`
end


desc "place the tarball into /usr/portage/distfiles/"
task :distfile => "sendhttp.tar.gz" do
	$time= Time.now unless $time
	`cp sendhttp.tar.gz /usr/portage/distfiles/sendhttp-#{$time.to_i}.tar.gz`
end
