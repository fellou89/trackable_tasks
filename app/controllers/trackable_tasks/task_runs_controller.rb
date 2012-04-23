# Index and show controller for TaskRuns 
# TaskRuns should not be created or edited here because they are generated by rake tasks 
class TrackableTasks::TaskRunsController < ApplicationController
  # Lists all tasks in task run 
  # Defaults to show today's tasks but can also show by week or all time
  def index    
    if params[:timeframe] =='week'
      @task_runs = TrackableTasks::TaskRun.newest_first.this_week
    elsif params[:timeframe] == 'all'
      @task_runs = TrackableTasks::TaskRun.newest_first
    else
      @task_runs = TrackableTasks::TaskRun.newest_first.today
    end

    # Paginate with kaminari if it is installed
    begin
      @task_runs = Kaminari.paginate_array(@task_runs.each).page(params[:page])
      @pagination_enabled = true
    rescue NameError => e
      @pagination_enabled = false
    end
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # Lists specific task run 
  def show
    @task_run = TrackableTasks::TaskRun.find_by_id(params[:id])
    
    
    respond_to do |format|
      format.html # show.html.erb
    end
    
  end
end
  
