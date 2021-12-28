require './lib/services/elasticsearch/feed'
desc 'Create indices and import data in Elastic Search'

namespace :elastic do
  task recreateIndices: :environment do
    Rake::Task['elastic:createIndices'].invoke
    Rake::Task['elastic:loadDataOnIndices'].invoke
    puts 'Indices created and data imported to Elastic Search'
  end

  task createIndices: :environment do
    puts 'Creating indices'
    repository = Elasticsearch::Feed::Repository.new
    repository.recreate_index!

    puts 'Indices created in Elastic Search'
  end

  task loadDataOnIndices: :environment do
    puts 'Importing data'
    Elasticsearch::UserRecord::Index.new.perform(User.all.pluck(:id))
    Elasticsearch::ProductRecord::Index.new.perform(Product.all.pluck(:id))
    puts 'Data imported to Elastic Search'
  end
end
