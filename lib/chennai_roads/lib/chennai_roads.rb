require "chennai_roads/version"

require "chennai_roads/logger"
require "chennai_roads/util"
require "chennai_roads/routing"
require "chennai_roads/dependencies"

require "chennai_roads/file_model"

module ChennaiRoads
  class Application
		def call(env)
			if env['PATH_INFO'] == '/favicon.ico' 
			 	return [404, {'Content-Type' => 'text/html'}, []]
      end

			begin
				klass, act = get_controller_and_action(env)
				controller = klass.new(env)

				controller.execute_before_filters

				text = controller.send(act)

				if controller.get_response
					st, hd, rs = controller.get_response.to_a
					[st, hd, [rs.body].flatten]
				else
					[200, {'Content-Type' => 'text/html'}, [text]]
				end

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

		def request
		  @request ||= Rack::Request.new(@env)
		end

		def params
			request.params
		end

		def get_response
			@response
		end

		def render_response(*args)
			response(render(*args))
		end

		def execute_before_filters
			self.class.get_before_filters.each{ |m| self.send(m) }
		end
	private
		def controller
			ChennaiRoads.to_underscore(self.class.to_s).gsub(/_controller/, "")
		end

		def response(text, status = 200, headers = {})
			raise "Already responded!" if @response
	    a = [text].flatten
	    @response = Rack::Response.new(a, status, headers)
		end

		def render(view_name, locals = {})
      filename = File.join "app", "views", controller, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result(context_data(locals))
		end

		def context_data(locals)
			locals
				.merge(:env => @env)
				.merge(serialize_instance_variables)
		end

		def serialize_instance_variables
			instance_variables.inject({}){ |h, v| h.merge(v => instance_variable_get(v) ) }
		end

		def self.before_filter(method)
			@before_filters ||= []
			@before_filters << method unless @before_filters.include?(method)
		end

		def self.get_before_filters
			@before_filters
		end
	end
end
