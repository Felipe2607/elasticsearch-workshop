class User < ActiveRecord::Base
  has_many :products, class_name: 'Product', dependent: :destroy
end