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
		class PortItem < RubyIOC::IOCTerm
			def get_type
				"PortItem"
			end
			
			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_netstat(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end

			def search_windows_netstat(indicator)
				netstat = get_windows_netstat
				
				blocks = netstat.split(/\n/)
				i = 1
				
				entries = []
				entry = ""
				blocks.each do | block |
					if i<5 then
						i+=1
						next
					end
					
					line = block.strip.gsub(/[ ]{2,}/, " ")
					localip = ""
					localport = ""
					pid = ""
					process = ""
					protocol = ""
					remoteip = ""
					remoteport = ""
					state = ""
					
					if line.match(/^TCP/) or line.match(/^UDP/) then
						nsentry = line.downcase.split(' ')
						protocol = nsentry[0]
						if nsentry[1].match(/\[/) then
							localip = nsentry[1].split(']:')[0].gsub(/\[/, '')
							localport = nsentry[1].split(']:')[1]
						else
							localip = nsentry[1].split(':')[0]
							localport = nsentry[1].split(':')[1]
						end
						if nsentry[2].match(/\[/) then
							remoteip = nsentry[2].split(']:')[0].gsub(/\[/, '')
							remoteport = nsentry[2].split(']:')[1]
						else
							remoteip = nsentry[2].split(':')[0]
							remoteport = nsentry[2].split(':')[1]
						end
						if nsentry.length < 5 then
							pid = nsentry[3]
						else
							state = nsentry[3]
							pid = nsentry[4]
						end
						
						indicator.each { |i|
							content = i[:content].downcase
							
							case i[:search]
							when "PortItem/CreationTime"
							when "PortItem/localIP"
								if content == localip then
									return true
								end
							when "PortItem/localPort"
								if content == localport then
									return true
								end
							when "PortItem/path"
							when "PortItem/pid"
								if content == pid then
									return true
								end
							when "PortItem/protocol"
								if content == protocol then
									return true
								end
							when "PortItem/remoteIP"
								if content == remoteip then
									return true
								end
							when "PortItem/remotePort"
								if content == remoteport then
									return true
								end
							when "PortItem/state"
								if content == state then
									return true
								end
							end
						}
					else
						if line.match(/^\[/)
							process = line.downcase.gsub("[", "").gsub("]", "")
							
							indicator.each { |i|
								content = i[:content].downcase
								case i[:search]
								when "PortItem/process"
									if content == process then
										return true
									end
								end
							}
						end
					end
				end
				
				return false
			end

			def get_windows_netstat
				netstat = `netstat -anbo`
				return netstat
			end
		end

		class PortItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"PortItem"
			end

			def create
				PortItem.new
			end
		end

		PortItemFactory.add_factory(PortItemFactory)
	end
end