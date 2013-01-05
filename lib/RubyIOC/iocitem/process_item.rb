module RubyIOC
	module IOCItem
		class ProcessItem < RubyIOC::IOCItem::IOC
			def get_type
				"ProcessItem"
			end
		end

		class ProcessItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"ProcessItem"
			end

			def create
				ProcessItem.new
			end
		end

		ProcessItemFactory.add_factory(ProcessItemFactory)
	end
end