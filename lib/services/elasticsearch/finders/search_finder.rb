require './lib/services/elasticsearch/feed'

module Elasticsearch
  class SearchFinder
    attr_accessor :type, :text

    def initialize(text:, type:)
      self.type = type
      self.text = text
    end

    def search
      response = Elasticsearch::Feed::Repository.search(query)

      response['hits']['hits']
    end

    private

    def query
      {
        sort: [
          '_score'
        ],
        query: {
          function_score: {
            query: type_search_query,
            functions: functions_array,
            min_score: min_score_function,
            score_mode: 'sum',
            boost_mode: 'replace'
          }
        }
      }
    end

    def valid_entities
      %w[user product]
    end

    def functions_array
      array = []
      array << string_match_query('name')
      array.compact
    end

    def min_score_function
      2.0
    end

    def type_search_query
      if valid_entities.include?(type)
        {
          bool: {
            must: [
              match: {
                type: type
              }
            ]
          }
        }
      else
        {
          match_all: {}
        }
      end
    end

    def string_match_query(field)
      {
        filter: {
          query_string: {
            default_field: field,
            query: text + '*'
          }
        },
        weight: 3
      }
    end
  end
end
