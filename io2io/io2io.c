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
