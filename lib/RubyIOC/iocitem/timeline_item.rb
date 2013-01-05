module RubyIOC
	module IOCItem
		class TimelineItem < RubyIOC::IOCItem::IOC
			def get_type
				"TimelineItem"
			end
		end

		class TimelineItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"TimelineItem"
			end

			def create
				TimelineItem.new
			end
		end

		TimelineItemFactory.add_factory(TimelineItemFactory)
	end
end