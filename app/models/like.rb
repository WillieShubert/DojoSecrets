class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :secret
  has_many :users, through: :likes, source: :users
end
