class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.all
  end

  def new
  end

  def create
    classroom = Classroom.new(classroom_params)
    if classroom.save
      redirect_to classrooms_path
    else
      render :new, status: :bad_request
    end
  end

  def show
    @classroom = Classroom.find_by(id: params[:id])
    if @classroom.nil?
      head :not_found
    end
  end

  def edit
    @classroom = Classroom.find_by(id: params[:id])
    if @classroom.nil?
      head :not_found
    end
  end

  def update
    @classroom = Classroom.find_by(id: params[:id])
    if @classroom.nil?
      head :not_found
    else
      @classroom.update_attributes(classroom_params)
      if @classroom.save
        redirect_to classroom_path(@classroom)
      else
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    classroom = Classroom.find_by(id: params[:id])
    if classroom.nil?
      head :not_found
    else
      classroom.destroy
      redirect_to classrooms_path
    end
  end

private
  def classroom_params
    params.require(:classroom).permit(:designation)
  end
end
