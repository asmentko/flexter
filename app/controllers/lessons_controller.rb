class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_course
    if current_user != current_user.enrolled_in?(@course)
      redirect_to course_path(current_lesson.section.course), alert: 'Please enroll in this course to view the lessons.'
    else      
      link_to lesson_path(lesson)
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
