require_relative "../lib/chennai_roads/application"

$LOAD_PATH << File.join(File.dirname(__FILE__),"..", "app","controllers")
require "quotes_controller"

module BestQuotes
	class Application < ChennaiRoads::Application
	end
end