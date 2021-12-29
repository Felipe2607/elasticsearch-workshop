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
    end
  end
end
