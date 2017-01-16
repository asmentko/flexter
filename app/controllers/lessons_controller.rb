class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
  end

  private

  # def require_authorized_for_current_lesson
  #   if current_user && current_user.enrolled_in?(@course)
  #     link_to lesson_path(lesson)
  #   else
  #     redirect_to course_path(current_lesson.section.course), alert: 'Please enroll in this course to view the lessons.'
  #   end
  # end

  def require_authorized_for_current_lesson
    if current_user && current_user.enrolled_in?(@course)
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
