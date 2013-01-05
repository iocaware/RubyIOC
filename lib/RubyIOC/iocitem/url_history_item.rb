module RubyIOC
	module IOCItem
		class UrlHistoryItem < RubyIOC::IOCItem::IOC
			def get_type
				"UrlHistoryItem"
			end
		end

		class UrlHistoryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"UrlHistoryItem"
			end

			def create
				UrlHistoryItem.new
			end
		end

		UrlHistoryItemFactory.add_factory(UrlHistoryItemFactory)
	end
end