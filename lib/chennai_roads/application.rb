module ChennaiRoads
  class Application
		def call(env)

			begin
				klass, act = get_controller_and_action(env)
				controller = klass.new(env)
				text = controller.send(act)

				[200, {'Content-Type' => 'text/html'}, [ text ]]
			rescue Exception => e
				`echo e.backtrace > debug.txt`;
			end

		end


		def get_controller_and_action(env)
			_, cont, action, after = env["PATH_INFO"].split('/', 4)
			cont = cont.capitalize
			cont += "Controller"

			[Object.const_get(cont), action]
		end
	end


	class Controller
		def initialize(env)
			@env = env
		end
		
		def env
			@env
		end
	end
end
