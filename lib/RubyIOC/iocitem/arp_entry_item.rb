module RubyIOC
	module IOCItem
		class ArpEntryItem < RubyIOC::IOCItem::IOC
			def get_type
				"ArpEntryItem"
			end
		end

		class ArpEntryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"ArpEntryItem"
			end

			def create
				ArpEntryItem.new
			end
		end

		ArpEntryItemFactory.add_factory(ArpEntryItemFactory)
	end
end