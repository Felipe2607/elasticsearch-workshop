require './././lib/services/elasticsearch/finders/search_finder'

module Api
  module V1
    class SearchController < ApplicationController
      def search_by_text
        text = params[:text]
        users = User.where('name LIKE ?', "%#{text}%").map do |u|
          { id: u.id, name: u.name, type: 'user' }
        end
        products = Product.where('name LIKE ?', "%#{text}%").map do |p|
          { id: p.id, name: p.name, type: 'product' }
        end
        render json: users.concat(products)
      end

      def search_by_text_es
        response = Elasticsearch::SearchFinder.new(custom_params: params).search

        render json: response
      end
    end
  end
end
