class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #@tasks = current_user.tasks
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: ture).recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  #@task = current_user.tasks.find(params[:id]
  end

  def update
    @task.update!(task_params)
    #@task = current_user.tasks.find(params[:id])
    #task.update!(task_params)
    redirect_to tasks_url, notice: "タスク 「#(task.name)」を更新しました"
  end

  def destroy
    #@task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "タスク 「#(task.name)」を削除しました"
  end

  def create
    @task = current_ser.tasks.new(task_params)
    if params [:back].present?
      render :new
      retrun
    end
    #@task = Task.new(task_params.merge(user_id: current_user.id))

    if @task.save
      redirect_to @task, notice: "タスク『#(@task.name)」を登録しました。"
    else
      render :new
    end
  end

  #def task_logger
    #@task_logger ||= Logger.new( 'log/task.log', 'daily')
  #end

  #task_logger.debug 'taskのログを出力'

　def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end


  private

  def task_params
    params.require(:task).permit(:name, :description)
  end


  def set_task
    @task = current_user.tasks.find(params[:id])
  end
