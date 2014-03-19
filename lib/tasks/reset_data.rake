namespace :db do
  desc "Clears out the Data We don't care"
  task :reset_data => :environment do
    puts "Clearing out Data"
    Job.destroy_all
    Resource.destroy_all
    Consumption.destroy_all
    Relation.destroy_all
    puts "Finished."
  end
end