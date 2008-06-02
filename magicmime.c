#include <ruby.h>
#include <magic.h>
#include <string.h>

magic_t cookie;

VALUE t_file(VALUE self, VALUE input)
{
	//SaveStringValue(input);
	char *result= magic_file(cookie, StringValueCStr(input));
	int errno;
	if (errno= magic_errno(cookie)) {
		rb_raise(rb_mErrno, errno);
		return Qnil;
	}
	char *error;
	if (error= magic_error(cookie)) {
		rb_raise(rb_eException, error);
		return Qnil;
	}
	return rb_str_new2(result);
}

VALUE M_magicmime;

void Init_magicmime()
{
	cookie= magic_open(MAGIC_SYMLINK | MAGIC_MIME_TYPE);
	magic_load(cookie, 0);
	M_magicmime= rb_define_module("MagicMime");
	rb_define_module_function(M_magicmime, "file", t_file, 1);
}
