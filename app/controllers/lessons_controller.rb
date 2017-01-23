class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_course
    unless current_user.enrolled_in?(current_course)
      redirect_to course_path(current_lesson.section.course), alert: "#{current_course.id} Please enroll in this course to view the lessons."
    else      
      lesson_path(current_lesson)
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  helper_method :current_course
  def current_course
    @current_course ||= current_lesson.section.course
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)
  end

end
