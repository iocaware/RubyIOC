module RubyIOC
	module IOCItem
		class ServiceItem < RubyIOC::IOCItem::IOC
			def get_type
				"ServiceItem"
			end
		end

		class ServiceItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"ServiceItem"
			end

			def create
				ServiceItem.new
			end
		end

		ServiceItemFactory.add_factory(ServiceItemFactory)
	end
end