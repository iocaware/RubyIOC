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
		class VolumeItem < RubyIOC::IOCTerm
			def get_type
				"VolumeItem"
			end
			
			def scan(indicator)
				if RubyIOC::Platform.windows?
					return search_windows_volumes(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end
			
			def search_windows_volumes(indicator)
				wmi = WIN32OLE.connect("winmgmts:\\")
				query = ""
				getLogicalDisk = false
				
				voltypes = Hash[
					"DRIVE_UNKNOWN" => "0", 
					"DRIVE_NO_ROOT_DIR" => "1", 
					"DRIVE_REMOVABLE" => "2", 
					"DRIVE_FIXED" => "3", 
					"DRIVE_REMOTE" => "4", 
					"DRIVE_CDROM" => "5", 
					"DRIVE_RAMDISK" => "6"
				]
				
				indicator.each { |i| 
					case i[:search]
					when "VolumeItem/ActualAvailableAllocationUnits"
						query += "FreeSpace = #{i[:content]} "
					when "VolumeItem/BytesPerSector"
						query += "BlockSize = #{i[:content]} "
					when "VolumeItem/CreationTime"
						query += "InstallDate = '#{i[:content]}' "
					when "VolumeItem/DevicePath"
					when "VolumeItem/DriveLetter"
						query += "DriveLetter = '#{i[:content]}' "
					when "VolumeItem/FileSystemFlags"
					when "VolumeItem/FileSystemName"
						query += "FileSystem = '#{i[:content]}' "
						getLogicalDisk = true
					when "VolumeItem/IsMounted"
					when "VolumeItem/Name"
						query += "VolumeName = '#{i[:content]}' "
						getLogicalDisk = true
					when "VolumeItem/SectorsPerAllocationUnit"
					when "VolumeItem/SerialNumber"
						query += "SerialNumber = '#{i[:content]}' "
					when "VolumeItem/TotalAllocationUnits"
						query += "Capacity = #{i[:content]} "
					when "VolumeItem/Type"
						query += "DriveType = #{voltypes[i[:content]]} "
					end
				}
				
				if getLogicalDisk then
					query = "Select * from Win32_LogicalDisk where " + query
				else
					query = "Select * from Win32_Volume where " + query
				end

				volumes = wmi.ExecQuery(query)
				volumes.each { |v|
					return true
				}
				return false
			end
		end

		class VolumeItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"VolumeItem"
			end

			def create
				VolumeItem.instance
			end
		end

		VolumeItemFactory.add_factory(VolumeItemFactory)
	end
end