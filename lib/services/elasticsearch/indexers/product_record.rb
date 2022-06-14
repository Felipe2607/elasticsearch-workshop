require_relative './index'

module Elasticsearch
  module ProductRecord
    class Index < Elasticsearch::Index
      def repository
        Feed::Repository
      end

      def body(id)
        product = Product.find(id)
        {
          id: product.id,
          name: product.name,
          type: type,
          location: {
            lat: product.latitude,
            lon: product.longitude
          }
        }
      end

      def type
        'product'
      end
    end
  end
end
