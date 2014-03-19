namespace :db do
  desc "Fill database with sample project"
  task sample_project: :environment do
    J1 = Job.create!(name: "Thema auswaehlen", duration: 1)
    J2 = Job.create!(name: "Problemstellung erfassen", duration: 2)
    J3 = Job.create!(name: "Mock-Ups erstellen", duration: 3)
    J4 = Job.create!(name: "Modell in GAMS implementieren", duration: 2)
    J5 = Job.create!(name: "Layout in RoR anpassen", duration: 3)
    J6 = Job.create!(name: "Datenbanken erstellen", duration: 4)
    J7 = Job.create!(name: "Datenbanken verknuepfen", duration: 6)
    J8 = Job.create!(name: "RoR und GAMS verknuepfen", duration: 8)
    J9 = Job.create!(name: "Nutzerfreundlichkeit verbessern", duration:3)
    J10 = Job.create!(name: "Hausarbeit schreiben", duration: 15)

    R1 = Resource.create!(name: "Arbeitskraft", capacity: 9)

    C1 = Consumption.create!(job_id: J1.id, resource_id: R1.id, consumption: 8)
    C2 = Consumption.create!(job_id: J2.id, resource_id: R1.id, consumption: 8)
    C3 = Consumption.create!(job_id: J3.id, resource_id: R1.id, consumption: 5)
    C4 = Consumption.create!(job_id: J4.id, resource_id: R1.id, consumption: 4)
    C5 = Consumption.create!(job_id: J5.id, resource_id: R1.id, consumption: 4)
    C6 = Consumption.create!(job_id: J6.id, resource_id: R1.id, consumption: 8)
    C7 = Consumption.create!(job_id: J7.id, resource_id: R1.id, consumption: 7)
    C8 = Consumption.create!(job_id: J8.id, resource_id: R1.id, consumption: 6)
    C9 = Consumption.create!(job_id: J9.id, resource_id: R1.id, consumption: 5)
    C10 = Consumption.create!(job_id: J10.id, resource_id: R1.id, consumption: 8)

    RE1 = Relation.create!(job_id: J1.id, successor_id: J2.id)
    RE2 = Relation.create!(job_id: J2.id, successor_id: J3.id)
    RE3 = Relation.create!(job_id: J2.id, successor_id: J4.id)
    RE4 = Relation.create!(job_id: J3.id, successor_id: J5.id)
    RE5 = Relation.create!(job_id: J3.id, successor_id: J6.id)
    RE6 = Relation.create!(job_id: J4.id, successor_id: J8.id)
    RE7 = Relation.create!(job_id: J5.id, successor_id: J9.id)
    RE8 = Relation.create!(job_id: J6.id, successor_id: J7.id)
    RE9 = Relation.create!(job_id: J7.id, successor_id: J8.id)
    RE10 = Relation.create!(job_id: J8.id, successor_id: J9.id)
    RE11 = Relation.create!(job_id: J9.id, successor_id: J10.id)

  end
end