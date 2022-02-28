require './././lib/services/elasticsearch/finders/search_finder'

module Api
  module V1
    class SearchController < ApplicationController
      def search_by_text
        text = params[:text]
        type = params[:type]&.downcase&.to_sym || :all
        users = %i[all user].include?(type) ? get_users_by_text(text) : []
        products = %i[all product].include?(type) ? get_products_by_text(text) : []
        render json: users.concat(products)
      end

      def search_by_text_es
        type = params[:type]&.downcase&.to_sym || :all
        response = Elasticsearch::SearchFinder.new(text: params[:text], type: type).search

        render json: response
      end

      private

      def get_users_by_text(text)
        User.where('name LIKE ?', "%#{text}%").map do |u|
          { id: u.id, name: u.name, type: 'user' }
        end
      end

      def get_products_by_text(text)
        Product.where('name LIKE ?', "%#{text}%").map do |p|
          { id: p.id, name: p.name, type: 'product' }
        end
      end
    end
  end
end
