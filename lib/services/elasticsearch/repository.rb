require 'elasticsearch'

module Elasticsearch
  class Repository
    class << self
      def store(*args)
        new.store(*args)
      end

      def bulk_store(*args)
        new.bulk_store(*args)
      end

      def search(*args)
        new.search(*args)
      end

      def msearch(*args)
        new.msearch(*args)
      end

      def delete(*args)
        new.delete(*args)
      end
    end

    def delete_index
      client.indices.delete(index: index)
    rescue Elasticsearch::Transport::Transport::Errors::NotFound # rubocop: disable Lint/HandleExceptions
      # did not exist; do not care
    end

    def recreate_index!
      delete_index
    ensure
      client.indices.create(index: index, body: settings_and_mappings)
    end

    def refresh_index
      client.indices.refresh(index: index)
    end

    def store(body:, id:, type:)
      client.index(
        index: index,
        id: id_key_for(id, type),
        body: body,
        type: '_doc'
      )
    end

    # expecting an array of {body: , id:} in items:
    def bulk_store(items, type)
      bulk_body = items.map do |item|
        body = item[:body]

        id = id_key_for(item[:id], type)

        [
          { index: { _index: index, _id: id, _type: '_doc' } }.to_json,
          body.to_json
        ]
      end.flatten.join("\n") + "\n"

      client.bulk(
        index: index,
        body: bulk_body
      )
    end

    # Search the index
    #
    def search(body, options = {})
      query = { index: index, body: body }.merge(options)
      result = client.search(query)
      result.compact
    end

    # Multi Search the index by more than one type
    #
    def msearch(body, options = {})
      query = { index: index, body: body }.merge(options)
      result = client.msearch(query)
      result.compact
    end

    def delete(id:, type:)
      key = id_key_for(id, type)

      client.delete(
        index: index,
        id: key,
        type: '_doc'
      )
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      if ENV['LOG_ELASTICSEARCH_QUERIES'] == 'true' && !::Rails.env.test?
        STDERR.puts "#{self.class} - WARN: attempted to delete non-existent record #{key}"
      end
    end

    def settings_and_mappings
      raise NoMethodError, 'Please define this method in your own class'
    end

    protected

    def index
      "#{index_name}_#{::Rails.env}"
    end

    def index_name
      raise NoMethodError, 'Please define this method in your own class'
    end

    def client
      @client ||= Elasticsearch::Client.new(
        url: ENV.fetch('ELASTIC_URL')
      )
    end
  end
end
