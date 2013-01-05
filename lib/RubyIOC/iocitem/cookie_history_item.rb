module RubyIOC
	module IOCItem
		class CookieHistoryItem < RubyIOC::IOCItem::IOC
			def get_type
				"CookieHistoryItem"
			end
		end

		class CookieHistoryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"CookieHistoryItem"
			end

			def create
				CookieHistoryItem.new
			end
		end

		CookieHistoryItemFactory.add_factory(CookieHistoryItemFactory)
	end
end