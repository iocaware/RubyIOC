require "test/unit"
require "RubyIOC"

class TestScan < Test::Unit::TestCase
	# def test_scan
		# find_windows_ioc = File.expand_path(File.dirname(__FILE__)) + "/find_windows.ioc"
		# test_user_item = File.expand_path(File.dirname(__FILE__)) + "/test_user_item.ioc"
		# RubyIOC::Scanner.new(File.read(test_user_item)).scan
		##puts RubyIOC::Scanner.new(File.read(test_user_item)).scan
	# end

	# def test_dns_scan
		# dns_test_ioc =  File.expand_path(File.dirname(__FILE__)) + "/test_dns_entry_item.ioc"
		# RubyIOC::Scanner.new(File.read(dns_test_ioc)).scan
	# end
	
	# def test_arp_scan
		# arp_test_ioc =  File.expand_path(File.dirname(__FILE__)) + "/test_arp_entry_item.ioc"
		# RubyIOC::Scanner.new(File.read(arp_test_ioc)).scan
	# end
	
	# def test_event_log
		# event_log_test_ioc =  File.expand_path(File.dirname(__FILE__)) + "/test_event_log_item.ioc"
		# RubyIOC::Scanner.new(File.read(event_log_test_ioc)).scan
	# end
	
	# def test_port_item
		# port_item_test_ioc =  File.expand_path(File.dirname(__FILE__)) + "/test_port_item.ioc"
		# RubyIOC::Scanner.new(File.read(port_item_test_ioc)).scan
	# end
	
	# def test_volume_item
		# volume_item_test_ioc =  File.expand_path(File.dirname(__FILE__)) + "/test_volume_item.ioc"
		# RubyIOC::Scanner.new(File.read(volume_item_test_ioc)).scan
	# end
	
	def test_service_item
		service_item_test_ioc =  File.expand_path(File.dirname(__FILE__)) + "/test_service_item.ioc"
		RubyIOC::Scanner.new(File.read(service_item_test_ioc)).scan
	end
end
