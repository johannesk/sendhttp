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
