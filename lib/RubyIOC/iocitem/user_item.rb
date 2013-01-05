module RubyIOC
	module IOCItem
		class UserItem < RubyIOC::IOCItem::IOC
			def get_type
				"UserItem"
			end
		end

		class UserItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"UserItem"
			end

			def create
				UserItem.new
			end
		end

		UserItemFactory.add_factory(UserItemFactory)
	end
end