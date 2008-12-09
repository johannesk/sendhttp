#
# © Johannes Krude 2008
#
# This file is part of sendhttp.
#
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
#

module HTML

	def HTML.base(content)
		["<?xml version=\"1.0\" encoding=\"UTF-8\" ?><!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>available files</title></head><body>#{content}#{HTML.hr}#{HTML.div("Delivired by sendhttp #{$version}. sendhttp is licensed under the AGPLv3 see #{HTML.a("http://www.gnu.org/licenses/agpl.html")}. The sourcecode is available at #{HTML.a("link", "link")}.")}</body></html>", {"Content-Type" => "text/html"}]
	end

	def HTML.h1(text)
		"<h1>#{text}</h1>"
	end

	def HTML.list(list)
		"<ul>#{list.collect { |l| "<li>#{l}</li>" }.join}</ul>"
	end

	def HTML.a(name, href= name)
		"<a href=\"#{href}\">#{name}</a>"
	end

	def HTML.div(content)
		"<div>#{content}</div>"
	end

	def HTML.form(vars, content)
		"<form#{vars}>#{content}</form>"
	end

	def HTML.input(type, vars)
		"<input type=\"#{type}\"#{vars} />"
	end

	def HTML.hr()
		"<hr />"
	end

end
