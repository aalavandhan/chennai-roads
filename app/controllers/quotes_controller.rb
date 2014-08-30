class QuotesController < ChennaiRoads::Controller

	def index
		@quotes = ChennaiRoads::Model::FileModel.all
		render :index, :quotes => @quotes
	end

	def a_quote
		render :a_quote, :noun => :winking
	end

	def quote
		@quote = ChennaiRoads::Model::FileModel.find(1)
		render :quote, :quote => @quote
	end

	def new_quote
	  attrs = {
	    "submitter" => "web user",
	    "quote" => "A picture is worth one k pixels",
	    "attribution" => "Me"
	  }
	  render :quote, :quote => ChennaiRoads::Model::FileModel.create(attrs)
	end
end