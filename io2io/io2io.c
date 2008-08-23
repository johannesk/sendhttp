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
#include <fcntl.h>
#include <sys/sendfile.h>

VALUE t_forever(VALUE self, VALUE in, VALUE out)
{
	int s, d;
	s= NUM2INT(in);
	d= NUM2INT(out);

	//deactivate O_NONBLOCK
	int flags_s= fcntl(s, F_GETFL);
	int flags_d= fcntl(d, F_GETFL);
	fcntl(s, F_SETFL, 0);
	fcntl(d, F_SETFL, 0);

	char buffer[1024];
	int size;
	while ((size= read(s, buffer ,sizeof(buffer)))>0) {
		if (size==-1)
			rb_sys_fail("io2io input");
		if (write(d, buffer, size)==-1)
			rb_sys_fail("io2io output");
	}

	fcntl(s, F_SETFL, flags_s);
	fcntl(d, F_SETFL, flags_d);

	return Qnil;
}

VALUE t_sendfile(VALUE self, VALUE in, VALUE out, VALUE size)
{
	int s, d;
	size_t si;
	s= NUM2INT(in);
	d= NUM2INT(out);
	if (NUM2INT(size) == -1)
		si= 0xffffffffffffffffffffffffffffffffffffff;
	else
		si= NUM2INT(size);

	//deactivate O_NONBLOCK
	int flags_s= fcntl(s, F_GETFL);
	int flags_d= fcntl(d, F_GETFL);
	fcntl(s, F_SETFL, 0);
	fcntl(d, F_SETFL, 0);

	if (sendfile(d, s, NULL, si) == -1)
		rb_sys_fail("sendfile");

	fcntl(s, F_SETFL, flags_s);
	fcntl(d, F_SETFL, flags_d);

	return Qnil;
}

VALUE M_io2io;

void Init_io2io()
{
	M_io2io= rb_define_module("IO2IO");
	rb_define_module_function(M_io2io, "forever", t_forever, 2);
	rb_define_module_function(M_io2io, "sendfile", t_sendfile, 3);
}
