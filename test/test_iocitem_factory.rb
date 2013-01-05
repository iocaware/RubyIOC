require "test/unit"
require "RubyIOC"

class TestIocItemFactory < Test::Unit::TestCase
	def test_factories_exist
		puts RubyIOC::IOCItem::IOCItemFactory.factories.size
		assert_not_nil RubyIOC::IOCItem::IOCItemFactory.factories
		assert_not_equal RubyIOC::IOCItem::IOCItemFactory.factories.size, 0
	end

	def test_factories_can_be_retrieved
		RubyIOC::IOCItem::IOCItemFactory.factories.each { |f|
		 type = f.new.get_type
		 assert_not_nil RubyIOC::IOCItem::IOCItemFactory.item_for(type)
		 assert_equal RubyIOC::IOCItem::IOCItemFactory.item_for(type).get_type, type
		}
	end
end
