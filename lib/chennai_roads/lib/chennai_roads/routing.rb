module ChennaiRoads
  class Application
  	def get_controller_and_action(env)
			return [Object.const_get("HomeController"), "index"] if env["PATH_INFO"] == "/"

			_, cont, action, after = env["PATH_INFO"].split('/', 4)

			cont = cont.capitalize
			cont += "Controller"

			[Object.const_get(cont), action]
		end
  end
end