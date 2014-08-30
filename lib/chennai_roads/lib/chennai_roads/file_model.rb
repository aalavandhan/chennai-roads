require "multi_json"
require "json"

module ChennaiRoads
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i
        load_data!
      end

      def [](name)
        @hash[name.to_s]
      end
      
      def []=(name, value)
        @hash[name.to_s] = value
      end

      def update(attrs)
        File.open("db/quotes/#{@id}.json", "w") do |f|
          f.write(attrs.to_json)
        end
        load_data!
      end

      def delete
        File.delete("db/quotes/#{@id}.json")
      end

      def self.find(id)
        FileModel.new("db/quotes/#{id}.json") rescue nil
      end

      def self.all
        files = Dir["db/quotes/*.json"]
        files.map { |f| FileModel.new f }
      end

      def self.create(attrs)
        hash = attrs || {}
        ["submitter", "quote", "attribution"].each{ |p| hash[p] = attrs[p] || "" }
        files = Dir["db/quotes/*.json"]
        names = files.map { |f| f.split("/")[-1] }
        highest = names.map(&:to_i).max
        id = highest + 1
        File.open("db/quotes/#{id}.json", "w") do |f|
          quote_data = {
            "submitter" => "#{hash["submitter"]}",
            "quote" => "#{hash["quote"]}",
            "attribution" => "#{hash["attribution"]}"
          }
          f.write(quote_data.to_json)
        end
        FileModel.new "db/quotes/#{id}.json"
      end
    private
      def load_data!
        obj = File.read(@filename)
        @hash = MultiJson.load(obj)
      end
    end
  end
end