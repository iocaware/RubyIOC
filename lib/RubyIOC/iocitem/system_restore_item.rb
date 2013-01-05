module RubyIOC
	module IOCItem
		class SystemRestoreItem < RubyIOC::IOCItem::IOC
			def get_type
				"SystemRestoreItem"
			end
		end

		class SystemRestoreItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"SystemRestoreItem"
			end

			def create
				SystemRestoreItem.new
			end
		end

		SystemRestoreItemFactory.add_factory(SystemRestoreItemFactory)
	end
end