require 'mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid , type: String
  field :name, type: String
  field :nickname, type: String
end
