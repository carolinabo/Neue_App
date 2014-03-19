class Consumption < ActiveRecord::Base
  attr_accessible :consumption, :job_id, :resource_id
  belongs_to :job
  belongs_to :resource
  validates :consumption, presence: true, :numericality => { :greater_than => 0}
end
