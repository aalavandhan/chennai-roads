class QuotesController < ChennaiRoads::Controller
	def a_quote
		render :a_quote, :noun => :winking
	end
end