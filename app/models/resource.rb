class Resource < ActiveRecord::Base
  attr_accessible :capacity, :name
  validates :name, presence: true, uniqueness: true, length: {maximum: 25}
  validates :capacity, presence: true, :numericality => { :greater_than => 0}

  has_many :consumptions
end
