#
# © Johannes Krude 2008
#
# This file is part of sendhttp.
#
#--
# sendhttp is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# sendhttp is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with sendhttp.  If not, see <http://www.gnu.org/licenses/>.
#++

# HTML provides helper functions to create html pages.
#
# All functions return a string. Under normal circumstances all pages
# should be constructed with the help of Html.base.
#
#==Example
# HTML.base(HTML.h1("heading")+HTML.list(["one", "two", "three"])
# will create a html page with a heading and a list.
module HTML

	# Returns a full html page. content must be a string which
	# will be embedded into the page.
	def HTML.base(content)
		["<?xml version=\"1.0\" encoding=\"UTF-8\" ?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>available files</title></head><body>#{content}#{HTML.hr}#{HTML.div("Delivired by sendhttp #{$version}. sendhttp is licensed under the #{HTML.a("AGPLv3", "/?license")}. The sourcecode is available #{HTML.a("here", "/?source")}.")}</body></html>", {"Content-Type" => "text/html"}]
	end

	# Returns a html h1 heading with text as text.
	def HTML.h1(text)
		"<h1>#{text}</h1>"
	end

	# Returns a html list, with the elements from the array list.
	def HTML.list(list)
		"<ul>#{list.collect { |l| "<li>#{l}</li>" }.join}</ul>"
	end

	# Returns a html link, text is the text to be displayed, href
	# the address, the link point's to.
	def HTML.a(text, href= name)
		"<a href=\"#{href}\">#{text}</a>"
	end

	# Returns a html div. A div is an unspecified block element.
	# content will be put between the opening and closing div
	# container.
	def HTML.div(content)
		"<div>#{content}</div>"
	end

	# Returns a html form. vars must be a string which will be
	# embedded into the html container. Content must be a string
	# which will be put between the opening and closing form
	# container's.
	def HTML.form(vars, content)
		"<form#{vars}>#{content}</form>"
	end

	# Returns an html input, this is to be used, as the content
	# for Html.form. vars must be a string, which will be
	# embedded into the input container. Possible types are: text,
	# password, submit, file ...
	def HTML.input(type, vars)
		"<input type=\"#{type}\"#{vars} />"
	end

	# Returns a html horizontal line.
	def HTML.hr()
		"<hr />"
	end

end
