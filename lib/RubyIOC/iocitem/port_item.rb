module RubyIOC
	module IOCItem
		class PortItem < RubyIOC::IOCItem::IOC
			def get_type
				"PortItem"
			end
		end

		class PortItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"PortItem"
			end

			def create
				PortItem.new
			end
		end

		PortItemFactory.add_factory(PortItemFactory)
	end
end