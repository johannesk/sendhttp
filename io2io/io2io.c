/*
 * © Johannes Krude 2008
 *
 * This file is part of sendfile-utils.
 *
 * broadcast-files is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * broadcast-files is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <ruby.h>
#include <errno.h>

VALUE t_forever(VALUE self, VALUE in, VALUE out)
{
	int s, d;
	s= NUM2INT(in);
	d= NUM2INT(out);
	char buffer[1024];
	int size;
	while ((size= read(s, buffer ,sizeof(buffer)))>0) {
		while (write(d, buffer, size)==-1 && errno==EAGAIN)
			errno= 0;
	}
	return Qnil;
}

VALUE M_io2io;

void Init_io2io()
{
	M_io2io= rb_define_module("IO2IO");
	rb_define_module_function(M_io2io, "forever", t_forever, 2);
}
