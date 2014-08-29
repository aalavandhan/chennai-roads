module ChennaiRoads
	class Logger
		def initialize(exception, log_file='log/exception.log')
			@e = exception
			@log_file = log_file
		end

		def log
			open(@log_file, 'a') { |f| 
				log_exception!
				3.times { f << "\n" }
			}
		end

	private
		def exception_message?
			@e.class == String
		end

		def log_exception!(file)
			if exception_message? 
				file << @e
			else log_exception(f)
				file << @e.message 
				file << @e.backtrace.join("\n")
			end
		end
	end
end