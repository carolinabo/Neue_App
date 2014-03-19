class Job < ActiveRecord::Base
  attr_accessible :begin, :duration, :end, :fez, :name, :sez
  validates :duration, presence: true, :numericality => { :greater_than => 0}
  validates :name, presence: true, length: {maximum: 45},  uniqueness: { case_sensitive: false }

  has_many :consumptions
  has_many :relations, foreign_key: "job_id"
  has_many :relations, foreign_key: "successor_id"
end
