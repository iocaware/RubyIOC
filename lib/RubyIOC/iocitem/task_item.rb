module RubyIOC
	module IOCItem
		class TaskItem < RubyIOC::IOCItem::IOC
			def get_type
				"TaskItem"
			end
		end

		class TaskItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"TaskItem"
			end

			def create
				TaskItem.new
			end
		end

		TaskItemFactory.add_factory(TaskItemFactory)
	end
end