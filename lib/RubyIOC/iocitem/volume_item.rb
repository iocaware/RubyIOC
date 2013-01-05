module RubyIOC
	module IOCItem
		class VolumeItem < RubyIOC::IOCItem::IOC
			def get_type
				"VolumeItem"
			end
		end

		class VolumeItemFactory < RubyIOC::IOCItem::IOCItemFactory
			def get_type
				"VolumeItem"
			end

			def create
				VolumeItem.new
			end
		end

		VolumeItemFactory.add_factory(VolumeItemFactory)
	end
end