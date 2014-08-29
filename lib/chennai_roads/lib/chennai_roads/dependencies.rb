class Object
  def self.const_missing(c)
    ChennaiRoads::Logger.new("Missing constant: #{c.inspect}!").log

    require ChennaiRoads.to_underscore(c.to_s)
    Object.const_get(c)
	end
end