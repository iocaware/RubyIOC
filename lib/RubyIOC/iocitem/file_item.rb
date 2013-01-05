module RubyIOC
	module IOCItem
		class FileItem < RubyIOC::IOCItem::IOC
			def get_type
				"FileItem"
			end
		end

		class FileItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"FileItem"
			end

			def create
				FileItem.new
			end
		end

		FileItemFactory.add_factory(FileItemFactory)
	end
end