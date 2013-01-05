module RubyIOC
	module IOCItem
		class RegistryHiveItem < RubyIOC::IOCItem::IOC
			def get_type
				"RegistryHiveItem"
			end
		end

		class RegistryHiveItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"RegistryHiveItem"
			end

			def create
				RegistryHiveItem.new
			end
		end

		RegistryHiveItemFactory.add_factory(RegistryHiveItemFactory)
	end
end