module RubyIOC
	module IOCItem
		class SystemInfoItem < RubyIOC::IOCItem::IOC
			def get_type
				"SystemInfoItem"
			end
		end

		class SystemInfoItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"SystemInfoItem"
			end

			def create
				SystemInfoItem.new
			end
		end

		SystemInfoItemFactory.add_factory(SystemInfoItemFactory)
	end
end