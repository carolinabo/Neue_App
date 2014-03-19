class Relation < ActiveRecord::Base
  attr_accessible :job_id, :successor_id
  belongs_to :job, class_name: "Job"
  belongs_to :successor, class_name: "Job"
end
