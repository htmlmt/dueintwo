require 'elasticsearch/model'

class Item < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :loans
  belongs_to :loaner, :class_name => "User"
  belongs_to :borrower, :class_name => "User"
end
