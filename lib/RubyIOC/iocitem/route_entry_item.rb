module RubyIOC
	module IOCItem
		class RouteEntryItem < RubyIOC::IOCItem::IOC
			def get_type
				"RouteEntryItem"
			end
		end

		class RouteEntryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"RouteEntryItem"
			end

			def create
				RouteEntryItem.new
			end
		end

		RouteEntryItemFactory.add_factory(RouteEntryItemFactory)
	end
end