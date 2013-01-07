require "test/unit"
require "RubyIOC"

class TestScan < Test::Unit::TestCase
	def test_scan
		find_windows_ioc = File.expand_path(File.dirname(__FILE__)) + "/find_windows.ioc"
		test_user_item = File.expand_path(File.dirname(__FILE__)) + "/test_user_item.ioc"
		#RubyIOC::Scanner.new(File.read(test_user_item)).scan
		#RubyIOC::Scanner.new(File.read(zeus_ioc)).scan
	end

	def test_user_item
		ui = RubyIOC::IOCItem::IOCItemFactory.item_for('UserItem')
		if RubyIOC::Platform.windows?
			assert_equal true, ui.search_by_username('Administrator','is'), "The Administrator user should have been found"
			assert_equal true, ui.search_by_fullname('UpdatusUser', 'is'), "The search by fullname failed"
			assert_equal false, ui.search_by_description("O RLY?", 'is'), "The search by description found O RLY?"
			assert_equal true, ui.search_by_description("Built-in account for guest access to the computer/domain", "is"), "The guest account was not found by description"
		else
			assert_equal true, ui.search_by_username('root', 'is'), "The root user was not found"
		end
		assert_equal false, ui.search_by_username('omgnotreal', 'is'), "The omgnotreal user should not have been found"
	end

end
