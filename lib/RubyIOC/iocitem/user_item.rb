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
		class UserItem < RubyIOC::IOCTerm
			def get_type
				"UserItem"
			end

			def scan(search, condition, content_type, content, context_type)
				case search
				when "UserItem/Username"
					return search_by_username(content, condition)
				when "UserItem/fullname"
					return search_by_fullname(content, condition)
				when "UserItem/description"
					return search_by_description(content, condition)
				else
					puts "Searching for #{search} is not impelemented"
				end
			end

			def get_users
				users = nil
				if RubyIOC::Platform.windows?
					wmi = WIN32OLE.connect("winmgmts://")
					users = wmi.ExecQuery("Select * from Win32_UserAccount Where LocalAccount = True")
				else
					puts "Platform has not been implemented yet"
				end
				return users
			end

			def search_by_username(content, condition)
				users = get_users
				usernames = []
				users.each { |u | 
					usernames << u.Name
				}
				return usernames.include?(content)
			end

			def search_by_fullname(content, condition)
				users = get_users
				fullnames = []
				users.each { |u|
					fullnames << u.FullName
				}
				return fullnames.include?(content)
			end

			def search_by_description(content, condition)
				users = get_users
				descriptions = []
				users.each { |u| 
					descriptions << u.Description
				}
				return descriptions.include?(content)
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