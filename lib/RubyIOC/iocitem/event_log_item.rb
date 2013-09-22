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

if RubyIOC::Platform.windows?
	require "win32ole"
end

module RubyIOC
	module IOCItem
		class EventLogItem < RubyIOC::IOCTerm
			def get_type
				"EventLogItem"
			end
		
			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_events(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end
			
			def search_windows_events(indicator)
				wmi = WIN32OLE.connect("winmgmts:{impersonationLevel=impersonate,(Security)}!\\")
				query = "Select * from Win32_NTLogEvent where "
				
				indicator.each { |i| 
					case i[:search]
					when "EventLogItem/category"
						query += "CategoryString = '#{i[:content]}' "
					when "EventLogItem/categoryNum"
						query += "Category = #{i[:content]} "
					when "EventLogItem/genTime"
					when "EventLogItem/EID"
						query += "EventIdentifier = #{i[:content]} "
					when "EventLogItem/log"
						query += "LogFile = '#{i[:content]}' "
					when "EventLogItem/machine"
						query += "ComputerName = '#{i[:content]}' "
					when "EventLogItem/message"
						query += "Message like '%#{i[:content]}%' "
					when "EventLogItem/source"
						query += "SourceName = '#{i[:content]}' "
					when "EventLogItem/type"
						query += "Type = '#{i[:content]}' "
					when "EventLogItem/user"
						query += "User like '%#{i[:content]}%' "
					when "EventLogItem/writeTime"
					end
				}

				events = wmi.ExecQuery(query)
				events.each { |e|
					return true
				}
				return false
			end
		end

		class EventLogItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"EventLogItem"
			end

			def create
				EventLogItem.instance
			end
		end

		EventLogItemFactory.add_factory(EventLogItemFactory)
	end
end