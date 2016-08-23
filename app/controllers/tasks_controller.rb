class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task, include: :users
  end

	def add_user
		task = Task.find_by(id: params[:task_id].to_i)
		user = User.find_by(id: params[:user_id].to_i)
		task.users << user
	end

  # POST /tasks
  def create
		auth_header = request.headers['Authorization']
		accept_header = request.headers['Accept']
		p "auth header: ", auth_header, "acc header: ", accept_header
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description)
    end
end
