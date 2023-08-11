class PostulationsController < ApplicationController
    before_action :authenticate_user!
    def user_postulation
        @user = current_user
        @job = Job.find(params[:job_id])
        #@user.id= current_user.id
        postulation = Postulation.find_by(user_id: @user.id, job_id: @job.id)
            if postulation
                return flash.now[:alert] = 'You already apply to this job'
            else
                @new_postulation = Postulation.new(user_id: @user.id, job_id: @job.id, kind: params[:kind])
                    respond_to do |format|
                        if @new_postulation.save!
                            format.html { redirect_to job_path(@job), notice: "#{current_user.email} You apply!" }
                        else
                            format.html { redirect_to job_path(@job), status: :unprocessable_entity }
                        end
                    end
            end
        end
    def job_with_postulation 
        @jobs= Job.all
        @postulations=current_user.postulations
        job_ids= @postulations.map(&:job_id)
        job =Job.where(id:job_ids)
end
end
