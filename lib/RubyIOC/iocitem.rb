module RubyIOC
	module IOCItem
		class IOCItemFactory

			def initialize
				IOCItemFactory.load
			end
			
			def get_type
				""
			end

			def create
				nil
			end

			@@factories = []

			def IOCItemFactory.add_factory(factory)
				@@factories.push(factory)
			end

			def IOCItemFactory.factories
				@@factories
			end

			def IOCItemFactory.item_for(type)
				@@factories.each { |itemfactory|
					itf = itemfactory.new
					if itf.get_type == type
						return itf.create
					end
				}
				nil
			end

			def IOCItemFactory.load
				directory = File.expand_path(File.dirname(__FILE__)) + "/iocitem"
				Dir.open(directory).each { |fn|
					next unless (fn =~ /[.]rb$/)
					require "#{directory}/#{fn}"
				}
			end
		end

		class IOC
			def get_type
				nil
			end

			def write(ioc)
				nil
			end
			
			def scan(ioc)
				nil
			end
		end
	end
end
RubyIOC::IOCItem::IOCItemFactory.load