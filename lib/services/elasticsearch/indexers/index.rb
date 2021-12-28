require 'sidekiq'

module Elasticsearch
  class Index
    def perform(*ids)
      items = ids.flatten.map do |id|
        body = body(id)

        # if body is nil, cancel indexing for this item
        next if body.blank?

        { id: id, body: body }
      end.flatten.compact

      return unless items.any?

      repository.bulk_store(items, type)
    end

    def body
      raise NoMethodError, "Please define body in #{self.class.name}"
    end

    def type
      raise NoMethodError, "Please define type in #{self.class.name}"
    end

    def repository
      raise NoMethodError, "Please define repository in #{self.class.name}"
    end
  end
end
