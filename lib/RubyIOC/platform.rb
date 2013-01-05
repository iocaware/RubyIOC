require "rbconfig"

module RubyIOC
	module Platform
		class << self
			def is?(what)
				what === RbConfig::CONFIG['host_os']
			end
			
			alias is is?

			def to_s
				RbConfig::CONFIG['host_os']
			end
		end

		module_function

		def linux?
			RubyIOC::Platform.is? /linux|cygwin/
		end

		def mac?
			RubyIOC::Platform.is? /mac|darwin/
		end

		def bsd?
			RubyIOC::Platform.is? /bsd/	
		end

		def windows?
			RubyIOC::Platform.is? /mswin|win|mingw/			
		end

		def solaris?
			RubyIOC::Platform.is? /solaris|sunos/
		end

		def posix?
			linux? or mac? or bsd? or solaris? or Process.respond_to(:fork)
		end
	end
end
