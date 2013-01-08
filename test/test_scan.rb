require "test/unit"
require "RubyIOC"

class TestScan < Test::Unit::TestCase
	def test_scan
		find_windows_ioc = File.expand_path(File.dirname(__FILE__)) + "/find_windows.ioc"
		test_user_item = File.expand_path(File.dirname(__FILE__)) + "/test_user_item.ioc"
		#RubyIOC::Scanner.new(File.read(test_user_item)).scan
		puts RubyIOC::Scanner.new(File.read(test_user_item)).scan
	end

end
