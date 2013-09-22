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
		class ArpEntryItem < RubyIOC::IOCTerm
			def get_type
				"ArpEntryItem"
			end

			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_arp(indicator)
				elseif Ruby::Platform::mac?
					return search_mac_arp(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end

			def search_windows_arp(indicator)
				arp = get_arp_cache

				arp.each_line do |line|
					indicator.each { |i|
						content = i[:content]

						case i[:search]
						when "ArpEntryItem/PhysicalAddress", "ArpEntryItem/CacheType", "ArpEntryItem/IPv4Address"
							if !(line.downcase.include? "interface") && (line.downcase.gsub("-", ":").include? content.downcase)
								return true
							end
						when "ArpEntryItem/Interface"
							if (line.downcase.include? "interface") && (line.downcase.include? content.downcase)
								return true
							end
						end
					}
				end
				#puts arp
				#puts arp.to_yaml
				return false
			end
			
			def search_mac_arp(indicator)
				arp = get_arp_cache
				arp.each_line do |line|
					fields = line.split(' ')
					ip = fields[1].gsub('(', '').gsub(')', '')
					physical = fields[3].downcase
					iface = fields[5].downcase

					indicator.each { |i|
						content = i[:content].downcase

						case i[:search]
						when "ArpEntryItem/PhysicalAddress"
							octets = physical.split(':')
							i = 0
							while i < octets.length do
								if octets[i].length == 1 then
									octets[i] = '0' + octets[i]
								end
								i += 1
							end
							physical = octets.join(':')

							if physical == content then
								return true
							end
						when "ArpEntryItem/CacheType"
						when "ArpEntryItem/IPv4Address"
							if ip == content then
								return true
							end
						when "ArpEntryItem/Interface"
							if iface == content then
								return true
							end
						end
					}
				end
				#puts arp
				#puts arp.to_yaml
				return false
			end

			def get_arp_cache
				arp_cache =`arp -a`

				return arp_cache
			end
		end

		class ArpEntryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"ArpEntryItem"
			end

			def create
				ArpEntryItem.instance
			end
		end

		ArpEntryItemFactory.add_factory(ArpEntryItemFactory)
	end
end


