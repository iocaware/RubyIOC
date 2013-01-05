module RubyIOC
	module IOCItem
		class DiskItem < RubyIOC::IOCItem::IOC
			def get_type
				"DiskItem"
			end
		end

		class DiskItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"DiskItem"
			end

			def create
				DiskItem.new
			end
		end

		DiskItemFactory.add_factory(DiskItemFactory)
	end
end