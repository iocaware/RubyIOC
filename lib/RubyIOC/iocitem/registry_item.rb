module RubyIOC
	module IOCItem
		class RegistryItem < RubyIOC::IOCItem::IOC
			def get_type
				"RegistryItem"
			end
		end

		class RegistryItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"RegistryItem"
			end

			def create
				RegistryItem.new
			end
		end

		RegistryItemFactory.add_factory(RegistryItemFactory)
	end
end