module RubyIOC
	module IOCItem
		class FormHistoryItem < RubyIOC::IOCItem::IOC
			def get_type
				"FormHistoryItem"
			end
		end

		class FormHistoryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"FormHistoryItem"
			end

			def create
				FormHistoryItem.new
			end
		end

		FormHistoryItemFactory.add_factory(FormHistoryItemFactory)
	end
end