module RubyIOC
	module IOCItem
		class DriverItem < RubyIOC::IOCItem::IOC
			def get_type
				"DriverItem"
			end
		end

		class DriverItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"DriverItem"
			end

			def create
				DriverItem.new
			end
		end

		DriverItemFactory.add_factory(DriverItemFactory)
	end
end