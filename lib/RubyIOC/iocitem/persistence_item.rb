module RubyIOC
	module IOCItem
		class PersistenceItem < RubyIOC::IOCItem::IOC
			def get_type
				"PersistenceItem"
			end
		end

		class PersistenceItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"PersistenceItem"
			end

			def create
				PersistenceItem.new
			end
		end

		PersistenceItemFactory.add_factory(PersistenceItemFactory)
	end
end