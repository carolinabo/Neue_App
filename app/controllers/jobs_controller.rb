class JobsController < ApplicationController

  before_filter :signed_in_user

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new (params[:job])
    if @job.save
      flash[:success] = "Job saved!"
      redirect_to jobs_path
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(params[:job])
      flash[:success] = "Update successful!"
      redirect_to jobs_path
    else
      render 'edit'
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:success] = "Job destroyed."
    redirect_to jobs_path
  end

   def calc_fezsez
    @jobs = Job.all
    @jobs.each { |jo|
     jo.fez=jo.duration
     @relations = Relation.all
      @relations.each{|re|
        if jo.id == re.successor_id
          if jo.fez < re.job.fez+jo.duration
          jo.fez=re.job.fez+jo.duration
         end
        end
      }
     jo.save
    }

    @jobs = Job.all
    @jobs.reverse_each { |jo|
      jo.sez=jo.fez
      @relations = Relation.all
      @relations.each{|re|
        if jo.id == re.job_id
          jo.sez = 0
        end
        if jo.id == re.job_id
          if jo.sez < re.successor.sez-re.successor.duration
            jo.sez=re.successor.sez-re.successor.duration
          end
        end
      }
      jo.save
    }

    flash[:success]="FEZ and SEZ calculated!"
    redirect_to jobs_path
end

  def delete_solution

    if File.exists?("Outputfile.txt")
      File.delete("Outputfile.txt")
    end

    @jobs = Job.all
    @jobs.each { |jo|
      jo.begin=0.0
      jo.end=0.0
      jo.save
    }

    @objective_function_value=nil
    flash[:success] = "Solution destroyed!"
    redirect_to current_user
  end

  def solve_problem
    if File.exist?("Inputfile.inc")
      File.delete("Inputfile.inc")
    end

    f=File.new("Inputfile.inc", "w")

    printf(f, "set r / \n")
    @resources = Resource.all
    @resources.each { |res| printf(f, "r" + res.id.to_s + "\n") }
    printf(f, "/; \n\n")

    printf(f, "set j / \n")
    printf(f, "Q \n")
    @jobs = Job.all
    @jobs.each { |jo| printf(f, "j"+jo.id.to_s + "\n" ) }
    printf(f, "S \n")
    printf(f, "/; \n\n")

    printf(f, "set t /t0*t50/; \n\n")

    printf(f, "VN(h,j)=no; \n")
    @jobs.each do |jo|
      printf(f, "VN('Q','j" + jo.id.to_s + "')=yes;\n")
      printf(f, "VN('j" + jo.id.to_s + "','S')=yes;\n" )
    end
    printf(f, "\n")

    @relations = Relation.all
    @relations.each { |rel| printf(f, "VN('j"+ rel.job.id.to_s + "','j" + rel.successor.id.to_s + "')=yes; \n") }
    printf(f, "\n")

    printf(f, "parameter \n")
    printf(f, "d(j) / \n")
    printf(f, "Q   0\n")
    printf(f, "S   0\n")
    @jobs = Job.all
    @jobs.each { |jo| printf(f, "j"+jo.id.to_s + "   " + jo.duration.to_s + "\n") }
    printf(f, "/\n")

    printf(f, "Kap(r) /\n")
    @resources.each { |res| printf(f, "r"+res.id.to_s+ "   " + res.capacity.to_s + "\n" ) }
    printf(f, "/;\n\n")


    printf(f, "k(j,r)=0;\n")
    @consumptions = Consumption.all
    @consumptions.each { |con| printf(f,"k('j"+con.job.id.to_s+"','r" + con.resource.id.to_s + "')=" + con.consumption.to_s+";\n")}
    f.close

    if File.exist?("Outputfile.txt")
      File.delete("Outputfile.txt")
    end

    system "C:\\GAMS\\win64\\24.1\\gams RCPSP_Modell"
    if File.exists?("Outputfile.txt")
      flash[:success] = "Optimization done!"
    else
      flash[:error] = "Optimization failed"
    end

    redirect_to current_user
  end


  def read_solution

    if File.exist?("Outputfile.txt")
      fi=File.open("Outputfile.txt", "r")
      line=fi.readline
      sa=line.split(" ")
      @objective_function_value=sa[1]
      fi.each { |line|
        sa=line.split(";")
        sa0=sa[0].delete "j "
#        sa1=sa[1].delete "t "
        sa1=sa[1].delete " \n"
        al=Job.find_by_id(sa0)
        al.end=sa1.to_i-1
        al.begin=sa1.to_i-1-al.duration
        al.save
      }
      fi.close
      @jobs = Job.all
      render "jobs/index"

    else
      flash.now[:not_available] = "Problem not solved!"
      @jobs = Job.all
      redirect_to jobs_url
     end
  end

  def load_project
    system "rake db:reset_data"
    system "rake db:sample_project"
    flash[:success] = "Sample Project loaded!"
    redirect_to current_user
  end


  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Bitte melden Sie sich an."
    end
  end

end