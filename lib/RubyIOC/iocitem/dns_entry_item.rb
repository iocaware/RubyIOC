module RubyIOC
	module IOCItem
		class DnsEntryItem < RubyIOC::IOCItem::IOC
			def get_type
				"DnsEntryItem"
			end
		end

		class DnsEntryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"DnsEntryItem"
			end

			def create
				DnsEntryItem.new
			end
		end

		DnsEntryItemFactory.add_factory(DnsEntryItemFactory)
	end
end