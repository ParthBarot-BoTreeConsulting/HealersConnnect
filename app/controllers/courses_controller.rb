class CoursesController < ApplicationController
  before_filter :course_from_params, only: [:show, :edit, :update,:destroy]

  def index
    @courses  = Course.page(params[:page]).per(Settings.pagination.per_page).order('created_at ASC')
  end

  def new
    @course  = Course.new
    @course_categories  = CourseCategory.all
  end

  def create
    @course  = Course.new(params[:course])
    @course_categories  = CourseCategory.all
    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: t('course.message.course_created',course: @course.name) }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
    @course_categories  = CourseCategory.all
  end

  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html {redirect_to courses_path, notice: t('course.message.course_updated',course: @course.name)}
      else
        @course_categories  = CourseCategory.all
        format.html {render :edit}
      end
    end
  end

  def destroy
    respond_to do |format|
      course_name = @course.name
      @course.destroy
      format.html {redirect_to courses_path, notice: t('course.message.course_destroy',course: course_name)}
    end
  end

  private

  def course_from_params
    @course = Course.find(params[:id])
  end
end