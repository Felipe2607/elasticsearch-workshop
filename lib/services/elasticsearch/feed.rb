require_relative './repository'
module Elasticsearch
  module Feed
    class Repository < Elasticsearch::Repository
      def settings_and_mappings # rubocop:disable MethodLength
        {
          mappings: {
            properties: {
              id: { type: 'integer' },
              name: { type: 'text' },
              type: { type: 'text' },
            }
          }
        }
      end

      protected

      def index_name
        'feed'
      end

      def id_key_for(id, type)
        "#{type}##{id}"
      end
    end
  end
end
