require "chennai_roads"

$LOAD_PATH << File.join(File.dirname(__FILE__),"..", "app","controllers")

module BestQuotes
	class Application < ChennaiRoads::Application
	end
end