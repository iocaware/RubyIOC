module RubyIOC
	module IOCItem
		class EventLogItem < RubyIOC::IOCItem::IOC
			def get_type
				"EventLogItem"
			end
		end

		class EventLogItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"EventLogItem"
			end

			def create
				EventLogItem.new
			end
		end

		EventLogItemFactory.add_factory(EventLogItemFactory)
	end
end