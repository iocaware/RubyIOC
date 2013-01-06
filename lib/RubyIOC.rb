# Copyright (c) 2013 Matt Jezorek
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
require "rexml/document"

require "RubyIOC/version"
require "RubyIOC/platform"
require "RubyIOC/iocterm"
require "RubyIOC/iocitem"
require "RubyIOC/ioc"
require "RubyIOC/scanner"

=begin rdoc
	RubyIOC is a simple gem that will allow the scanning of a system with indicators of compromise. RubyIOC will not tell you if the machine
	is compromised or not but it will give you a score and what indicators have been found. Ideally you will want to see 0% and 0 found indicators.
	However you may come back with 1% ond 2 indicators out of 200. It will also provide you a reference to the found indicators. From here you
	can investigate whatever machine you wish to investigate. 

	Please note that when you use this software you are running on possibly compromised machiens, any credentials you use to facilitate the scan 
	should be considered compromised
=end