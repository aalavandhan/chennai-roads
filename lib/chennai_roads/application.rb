module ChennaiRoads
  class Application
		def call(env)
			[200, {'Content-Type' => 'text/html'}, ["Hello from Ruby on ChennaiRoads!"]]
		end
	end
end
