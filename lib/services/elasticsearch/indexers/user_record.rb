require_relative './index'

module Elasticsearch
  module UserRecord
    class Index < Elasticsearch::Index
      def repository
        Feed::Repository
      end

      def body(id)
        user = User.find(id)
        {
          id: user.id,
          name: user.name,
          type: type,
          location: {
            lat: user.latitude.to_f,
            lon: user.longitude.to_f
          }
        }
      end

      def type
        'user'
      end
    end
  end
end
