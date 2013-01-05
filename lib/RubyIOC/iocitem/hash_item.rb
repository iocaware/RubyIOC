module RubyIOC
	module IOCItem
		class HashItem < RubyIOC::IOCItem::IOC
			def get_type
				"HashItem"
			end
		end

		class HashItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"HashItem"
			end

			def create
				HashItem.new
			end
		end

		HashItemFactory.add_factory(HashItemFactory)
	end
end