module RubyIOC
	module IOCItem
		class PrefetchItem < RubyIOC::IOCItem::IOC
			def get_type
				"PrefetchItem"
			end
		end

		class PrefetchItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"PrefetchItem"
			end

			def create
				PrefetchItem.new
			end
		end

		PrefetchItemFactory.add_factory(PrefetchItemFactory)
	end
end