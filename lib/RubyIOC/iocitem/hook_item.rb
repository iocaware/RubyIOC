module RubyIOC
	module IOCItem
		class HookItem < RubyIOC::IOCItem::IOC
			def get_type
				"HookItem"
			end
		end

		class HookItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"HookItem"
			end

			def create
				HookItem.new
			end
		end

		HookItemFactory.add_factory(HookItemFactory)
	end
end