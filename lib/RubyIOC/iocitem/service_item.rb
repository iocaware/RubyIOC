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
		class ServiceItem < RubyIOC::IOCTerm
			def get_type
				"ServiceItem"
			end
			
			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_services(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end
			
			def search_windows_services(indicator)
				wmi = WIN32OLE.connect("winmgmts:\\")
				query = "Select * from Win32_Service where "
				getLogicalDisk = false
				
				servicemodetypes = Hash[
					"SERVICE_AUTO_START" => "Auto", 
					"SERVICE_BOOT_START" => "Boot", 
					"SERVICE_DEMAND_START" => "Manual", 
					"SERVICE_DISABLED" => "Disabled", 
					"SERVICE_SYSTEM_START" => "System", 
				]
				
				servicestatustypes = Hash[
					"SERVICE_CONTINUE_PENDING" => "Continue Pending", 
					"SERVICE_PAUSE_PENDING" => "Pause Pending", 
					"SERVICE_PAUSED" => "Paused", 
					"SERVICE_RUNNING" => "Running", 
					"SERVICE_START_PENDING" => "Start Pending", 
					"SERVICE_STOP_PENDING" => "Stop Pending", 
					"SERVICE_STOPPED" => "Stopped", 
					#***#
					"SERVICE_UNKNOWN" => "Unknown"
				]
				
				servicetypetypes = Hash[
					"SERVICE_KERNEL_DRIVER" => "Kernel Driver", 
					"SERVICE_FILE_SYSTEM_DRIVER" => "File System Driver", 
					"SERVICE_WIN32_OWN_PROCESS" => "Own Process", 
					"SERVICE_WIN32_SHARE_PROCESS" => "Share Process", 
					#***#
					"SERVICE_ADAPTER" => "Adapter", 
					"SERVICE_RECOGNIZER_DRIVER" => "Recognizer Driver", 
					"SERVICE_WIN32_INTERACTIVE_PROCESS" => "Interactive Process"
				]
				
				indicator.each { |i| 
					case i[:search]
					when "ServiceItem/arguments"
					when "ServiceItem/description"
						query += "Description like '%#{i[:content]}%' "
					when "ServiceItem/descriptiveName"
						query += "DisplayName = '#{i[:content]}' "
					when "ServiceItem/serviceDLL"
					when "ServiceItem/serviceDLLCertificateIssuer"
					when "ServiceItem/serviceDLLCertificateSubject"
					when "ServiceItem/serviceDLLmd5sum"
					when "ServiceItem/serviceDLLsha1sum"
					when "ServiceItem/serviceDLLsha256sum"
					when "ServiceItem/serviceDLLSignatureDescription"
					when "ServiceItem/serviceDLLSignatureVerified"
					when "ServiceItem/serviceDLLSignatureExists"
					when "ServiceItem/mode"
						query += "StartMode = '#{servicemodetypes[i[:content]]}' "
					when "ServiceItem/name"
						query += "Name = '#{i[:content]}' "
					when "ServiceItem/path"
						content = i[:content].gsub("\\", "\\\\\\\\")
						query += "PathName like '%#{[content]}%' "
					when "ServiceItem/pathCertificateIssuer"
					when "ServiceItem/pathCertificateSubject"
					when "ServiceItem/pathmd5sum"
					when "ServiceItem/pathsha1sum"
					when "ServiceItem/pathsha256sum"
					when "ServiceItem/pathSignatureDescription"
					when "ServiceItem/pathSignatureExists"
					when "ServiceItem/pathSignatureVerified"
					when "ServiceItem/pid"
						query += "ProcessID = #{i[:content]} "
					when "ServiceItem/startedAs"
						query += "StartName = '#{i[:content]}' "
					when "ServiceItem/status"
						query += "State = '#{servicestatustypes[i[:content]]}' "
					when "ServiceItem/type"
						query += "ServiceType = '#{servicetypetypes[i[:content]]}' "
					when "ServiceItem/serviceDLLMd54Ksum"
					when "ServiceItem/serviceDLLSha512Sum"
					when "ServiceItem/serviceDLLSsdeep"
					when "ServiceItem/pathMd54ksum"
					when "ServiceItem/pathSha512sum"
					when "ServiceItem/pathSsdeep"
					end
				}
				
				services = wmi.ExecQuery(query)
				services.each { |s|
					return true
				}
				return false
			end
		end
		

		class ServiceItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"ServiceItem"
			end

			def create
				ServiceItem.new
			end
		end

		ServiceItemFactory.add_factory(ServiceItemFactory)
	end
end