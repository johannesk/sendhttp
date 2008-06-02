all: io2io magicmime

clean: clean-io2io clean-magicmime

io2io: makefile-io2io
	make -C io2io

clean-io2io: makefile-io2io
	make -C io2io clean
	rm io2io/Makefile

makefile-io2io: io2io/extconf.rb
	cd io2io
	ruby  -Cio2io extconf.rb

magicmime: makefile-magicmime
	make -C magicmime

clean-magicmime: makefile-magicmime
	make -C magicmime clean
	rm magicmime/Makefile

makefile-magicmime: io2io/extconf.rb
	cd magicmime
	ruby -Cmagicmime extconf.rb
