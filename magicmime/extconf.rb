#!/bin/env ruby
require 'mkmf'
have_library("magic")
create_makefile("magicmime")
