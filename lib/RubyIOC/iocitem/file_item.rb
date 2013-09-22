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
		class FileItem < RubyIOC::IOCTerm
			def get_type
				"FileItem"
			end

			def scan(indicator)
				if RubyIOC::Platform.windows?
					return scan_windows_files(indicator)
				else
					puts "Not implemented on this platform yet"
				end
			end


			def scan_windows_files(indicator)
				indicator.each { |i|
					case i[:search]
					when 'FileItem/DevicePath'
					when 'FileItem/FullPath'
					when 'FileItem/Drive'
					when 'FileItem/FilePath'
					when 'FileItem/FileName'
						return search_windows(i[:content])
					when 'FileItem/FileExtension'
					when 'FileItem/SizeInBytes'
					when 'FileItem/Created'
					when 'FileItem/Modified'
					when 'FileItem/Changed'
					when 'FileItem/FilenameCreated'
					when 'FileItem/FilenameAccessed'
					when 'FileItem/FilenameChanged'
					when 'FileItem/FileAttributes'
					when 'FileItem/Username'
					when 'FileItem/SecurityID'
					when 'FileItem/SecurityType'
					when 'FileItem/INode'
					when 'FileItem/StreamList/Stream'
					when 'FileItem/PEInfo'
					when 'FileItem/PEInfo/DigitalSignature/SignatureExists'
					when 'FileItem/PeakEntropy'
					when 'FileItem/PeakCodeEntropy'
					when 'FileItem/StringList/string'
					when 'FileItem/Sha512sum'
					when 'FileItem/Md5sum'
					when 'FileItem/Sha1sum'
					when 'FileItem/Sha256sum'
					when 'FileItem/Md54ksum'
					end
				}
				return false
			end

			def search_windows(str)
				Dir.chdir "\\"
				results = false
				sr = `dir /s #{str}`
				if sr.include?("File Not Found")
					results = false
				else
					results = true
				end				
				return results
			end


		end

		

		class FileItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"FileItem"
			end

			def create
				FileItem.instance
			end
		end

		FileItemFactory.add_factory(FileItemFactory)
	end
end