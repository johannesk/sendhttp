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

io2io: io2io/Makefile
	make -C io2io

clean-io2io: io2io/Makefile
	make -C io2io clean

magicmime: magicmime/Makefile
	make -C magicmime

clean-magicmime: magicmime/Makefile
	make -C magicmime clean
