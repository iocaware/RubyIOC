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
require "pp"
module RubyIOC
	class Scanner
		def initialize(iocXML)
			@ioc = RubyIOC::IOC.from_xml(iocXML)
		end

		def scan
			results = []
			indicators = []

			@ioc.indicators.each { |i| 
				process_indicators(i, results)
			}
		end

		def get_all_results(items, results)
			items.each { | a | 
				a.each_pair { |k,v| 
					results << v['result']
				}
			}
			return results
		end

		def get_result(operator, results) 
			result = false
			# setup what indicators we want
			indicators = results['indicators']
			if indicators.empty? 
				indicators = get_all_results(results['items'], [])
			end
			case operator
			when "OR"
				result = false
				indicators.each { |ind |
					if ind == true
						result = true
					end
				}
			when "AND"
				result = true
				indicators.each { |ind|
					if ind == false
						result = false
					end
				}
			else 
				puts "You have me an invalid operator"
			end
			return result
		end

		def process_indicators(i, results)
			res = {}
			res[i.id] = {}
			res[i.id]['items'] = []
			res[i.id]['operator'] = i.operator
			res[i.id]['indicators'] = []
			i.indicator_item.each { | inditem |
				# HERE IS WHERE WE PROCESS THE INDICATOR ITEMS
				# def scan(search, condition, content_type, content, context_type)
				puts RubyIOC::IOCItem::IOCItemFactory.item_for(inditem.document).scan(inditem.search, inditem.condition, inditem.content_type, inditem.content, inditem.context_type)
				res[i.id]['indicators'] << [true, false].sample
			}
			i.indicators.each { |ii |
				process_indicators(ii, res[i.id]['items'])
			}
			res[i.id]['result'] = get_result(i.operator, res[i.id])
			results << res
		end

	end
end