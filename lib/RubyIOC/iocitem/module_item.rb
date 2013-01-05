module RubyIOC
	module IOCItem
		class ModuleItem < RubyIOC::IOCItem::IOC
			def get_type
				"ModuleItem"
			end
		end

		class ModuleItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"ModuleItem"
			end

			def create
				ModuleItem.new
			end
		end

		ModuleItemFactory.add_factory(ModuleItemFactory)
	end
end