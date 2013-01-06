require "test/unit"
require "RubyIOC"

class TestScan < Test::Unit::TestCase
	def test_scan
		find_windows_ioc = File.expand_path(File.dirname(__FILE__)) + "/find_windows.ioc"
		zeus_ioc = File.expand_path(File.dirname(__FILE__)) + "/zeus.ioc"
		RubyIOC::Scanner.new(File.read(find_windows_ioc)).scan
		#RubyIOC::Scanner.new(File.read(zeus_ioc)).scan
	end
end
