module RubyIOC
	module IOCItem
		class FileDownloadHistoryItem < RubyIOC::IOCItem::IOC
			def get_type
				"FileDownloadHistoryItem"
			end
		end

		class FileDownloadHistoryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"FileDownloadHistoryItem"
			end

			def create
				FileDownloadHistoryItem.new
			end
		end

		FileDownloadHistoryItemFactory.add_factory(FileDownloadHistoryItemFactory)
	end
end