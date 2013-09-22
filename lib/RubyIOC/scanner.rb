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
require "rubygems"
require "active_support"
require "yaml"

module RubyIOC
	class Scanner
		def initialize(iocXML)
			@ioc = RubyIOC::IOC.from_xml(iocXML)
		end

		def scan
			results = {}
			indicators = []
			@ioc.indicators.each { |i| 
				process_indicators(i, results)
			}
			return results
		end


		def process_indicators(i, results)
			results[i.id] = Hash.new
			overall = []
			i.indicator_item.each { | inditem |
				tmp = {}
				tmp[:document] = inditem.document
				tmp[:search] = inditem.search
				tmp[:condition] = inditem.condition
				tmp[:content_type] = inditem.content_type
				tmp[:content] = inditem.content
				tmp[:context_type] = inditem.context_type
				#res[i.id]['indicators'] 
				rs = RubyIOC::IOCItem::IOCItemFactory.item_for(inditem.document).scan([tmp])
				overall << rs
				results[i.id][inditem.id] = rs
			}
			case i.operator
			when "AND"
				results[i.id]['status'] = overall.all? { |t| t == true}
			when "OR"
				results[i.id]['status'] = overall.any? {|t| t == true }
			end
			i.indicators.each { |ii |
				process_indicators(ii, results)
			}
			return results
		end

	end
end