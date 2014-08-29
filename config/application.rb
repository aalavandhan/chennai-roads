require_relative "../lib/chennai_roads/logger"
require_relative "../lib/chennai_roads/util"
require_relative "../lib/chennai_roads/const_missing"
require_relative "../lib/chennai_roads/application"

$LOAD_PATH << File.join(File.dirname(__FILE__),"..", "app","controllers")
require "quotes_controller"
require "home_controller"

module BestQuotes
	class Application < ChennaiRoads::Application
	end
end