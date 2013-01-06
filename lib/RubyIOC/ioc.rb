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

=begin rdoc
=end
require "roxml"

module RubyIOC

	class IndicatorItem
		include ROXML
		xml_name 'IndicatorItem'
		xml_reader :id, :from => "@id"
		xml_reader :condition, :from => "@condition"
		xml_reader :context, :from => "Context"
		xml_reader :content, :from => "Content"
		xml_reader :document, :from => "@document", :in => "Context"
		xml_reader :search, :from => "@search", :in => "Context"
		xml_reader :context_type, :from => "@type", :in => "Context"
		xml_reader :content_type, :from => "@type", :in => "Content"

	end

	class Indicator
		include ROXML
		xml_name 'Indicator'
		xml_reader :id, :from => "@id"
		xml_reader :operator, :from => "@operator"
		xml_reader :indicator_item, :as => [RubyIOC::IndicatorItem]
		xml_reader :indicators, :as => [RubyIOC::Indicator]
	end

	class IOC
		include ROXML
=begin rdoc
		This class is to create the IOC XML file so that we can read it in and process it easily
=end
		xml_reader :id, :from => "@id"
		xml_reader :last_modified, :from => "@last-modified"
		xml_reader :short_description
		xml_reader :description
		xml_reader :keywords
		xml_reader :authored_by
		xml_reader :authored_date
		xml_reader :links
		xml_reader :indicators, :as => [RubyIOC::Indicator], :in => "definition"
	end
end