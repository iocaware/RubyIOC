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
module RubyIOC
	module IOCItem
		class IOCItemFactory

			def initialize
				IOCItemFactory.load
			end
			
			def get_type
				""
			end

			def create
				nil
			end

			@@factories = []

			def IOCItemFactory.add_factory(factory)
				@@factories.push(factory)
			end

			def IOCItemFactory.factories
				@@factories
			end

			def IOCItemFactory.item_for(type)
				@@factories.each { |itemfactory|
					itf = itemfactory.new
					if itf.get_type == type
						return itf.create
					end
				}
				nil
			end

			def IOCItemFactory.load
				directory = File.expand_path(File.dirname(__FILE__)) + "/iocitem"
				Dir.open(directory).each { |fn|
					next unless (fn =~ /[.]rb$/)
					require "#{directory}/#{fn}"
				}
			end
		end
	end
end
RubyIOC::IOCItem::IOCItemFactory.load