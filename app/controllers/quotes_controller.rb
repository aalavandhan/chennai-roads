class QuotesController < ChennaiRoads::Controller

	def index
		@quotes = ChennaiRoads::Model::FileModel.all
		render_response :index
	end

	def new
		@quote = ChennaiRoads::Model::FileModel.create(quote_params)
	  render_response :quote
	end

	def show
		load_quote
		render_response :quote
	end

	def update
		load_quote
		@quote.update(quote_params)
	  render_response :quote
	end

	def delete
		load_quote
		@quote.delete
	  render_response :quote
	end

private
	def load_quote
		@quote = ChennaiRoads::Model::FileModel.find(params["id"])
	end

	def quote_params
		{
		  "submitter" =>  params["submitter"],
		  "quote" =>  params["quote"],
		  "attribution" =>  params["attribution"]
		}
	end
end