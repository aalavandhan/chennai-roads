require "chennai_roads/version"

require "chennai_roads/logger"
require "chennai_roads/util"
require "chennai_roads/routing"
require "chennai_roads/dependencies"

module ChennaiRoads
  class Application
		def call(env)
			if env['PATH_INFO'] == '/favicon.ico' 
			 	return [404, {'Content-Type' => 'text/html'}, []]
      end

			begin
				klass, act = get_controller_and_action(env)
				controller = klass.new(env)
				text = controller.send(act)

				[200, {'Content-Type' => 'text/html'}, [ text ]]
			rescue Exception => e
				Logger.new(e).log
			end
		end
	end

	class Controller
		def initialize(env)
			@env = env
		end
		
		def env
			@env
		end

		def render(view_name, locals = {})
      filename = File.join "app", "views", controller, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(:env => @env)
		end

	private
		def controller
			ChennaiRoads.to_underscore(self.class.to_s).gsub(/_controller/, "")
		end
	end
end
