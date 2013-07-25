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
require "yaml"
if RubyIOC::Platform.windows?
	require "win32ole"
end
module RubyIOC
	module IOCItem
		class UserItem < RubyIOC::IOCTerm
			def get_type
				"UserItem"
			end

			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_users(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end

			def search_windows_users(indicator)
				wmi = WIN32OLE.connect("winmgmts://")
				query = "Select * from Win32_UserAccount Where LocalAccount = True and "
				attributes = []
				indicator.each { |i| 
					case i[:search]
					when "UserItem/username"
						attributes << "Name = \"#{i[:content]}\""
					when "UserItem/fullname"
						attributes << "FullName = \"#{i[:content]}\""
					when "UserItem/description"
						attributes << "Description = \"#{i[:content]}\""
					when "UserItem/grouplist"
					when "UserItem/SecurityID"
						attributes << "SID = \"#{i[:content]}\""
					when "UserItem/SecurityType"
						attributes << "SIDType = \"#{i[:content]}\""
					when "UserItem/LastLogin"
					when "UserItem/disabled"
						attributes << "Disabled = #{i[:content].to_bool}"
					when "UserItem/lockedout"
						attributes << "Lockout = #{i[:content].to_bool}"
					when "UserItem/passwordrequired"
					when "UserItem/userpasswordage"
					when "UserItem/homedirectory"
					when "UserItem/scriptpath"
					end
				}
				query = query + attributes.join(" and ")
				users = wmi.ExecQuery(query)
				users.each { | u | 
					return true
				}
				return false
			end
		end

		class UserItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"UserItem"
			end

			def create
				UserItem.new
			end
		end

		UserItemFactory.add_factory(UserItemFactory)
	end
end
