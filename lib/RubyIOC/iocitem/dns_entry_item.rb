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
		class DnsEntryItem < RubyIOC::IOCTerm
			def get_type
				"DnsEntryItem"
			end

			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_dns(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end

			def search_windows_dns(indicator)
				dns = get_windows_dns_cache
				puts dns.to_yaml
				return false
			end

			def get_windows_dns_cache
				dns = []
				dns_cache =`ipconfig /displaydns`
				blocks = dns_cache.split(/\n\n/)
				blocks.each do | block |
					#puts block
					temp = {}
					temp[:record_name] = block.match(/\s*Record Name.*:\s(?<record>.*)/).to_a[1]
					temp[:record_type] = block.match(/\s*Record Type.*:\s(?<record>.*)/).to_a[1]
					temp[:time_to_live] = block.match(/\s*Time To Live.*:\s(?<record>.*)/).to_a[1]
					temp[:data_length] = block.match(/\s*Data Length.*:\s(?<record>.*)/).to_a[1]
					temp[:section] = block.match(/\s*Section.*:\s(?<record>.*)/).to_a[1]
					temp[:a_record] = block.match(/\s*A \(Host\) Record.*:\s(?<record>.*)/).to_a[1]
					temp[:cname] = block.match(/\s*CNAME Record.*:\s(?<record>.*)/).to_a[1]
					dns << temp
				end
				return dns
			end
		end

		class DnsEntryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"DnsEntryItem"
			end

			def create
				DnsEntryItem.new
			end
		end

		DnsEntryItemFactory.add_factory(DnsEntryItemFactory)
	end
end