#!/bin/env ruby

require './portage'
require './git'
require 'erb'

$git= Git.new
$rev= $git.rev

$time= Time.now.to_i
$portage= Portage.overlay


unless $portage
	STDERR.puts "Could not find overlay"
	exit 1
end

$portage.mkdir("net-misc/sendhttp")
file= File.open("#{$portage.dir}/net-misc/sendhttp/sendhttp-#{$time}.ebuild", "w")
file.write(ERB.new(File.open("ebuild.eruby", "r").read).result(binding))
file.close
$portage.add_file("net-misc/sendhttp", :ebuild, "sendhttp-#{$time}.ebuild")
`cd ..; git-archive --format=tar #{$rev} | gzip > /usr/portage/distfiles/sendhttp-#{$rev}.tar.gz`
$portage.add_file("net-misc/sendhttp", :dist, "sendhttp-#{$rev}.tar.gz")
