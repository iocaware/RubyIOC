module RubyIOC
	module IOCItem
		class StringMatchItem < RubyIOC::IOCItem::IOC
			def get_type
				"StringMatchItem"
			end
		end

		class StringMatchItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"StringMatchItem"
			end

			def create
				StringMatchItem.new
			end
		end

		StringMatchItemFactory.add_factory(StringMatchItemFactory)
	end
end