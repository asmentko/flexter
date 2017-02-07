class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:create]
  before_action :require_authorized_for_current_lesson, only: [:update]

  def create
    @lesson = current_section.lessons.create(lesson_params)
    course = @lesson.section.course
    redirect_to instructor_course_path(course)
  end

  # begin edit addition
  def edit
    @lesson = Lesson.find(params[:id])
  end
  # end addition

  # begin destroy addition
  def destroy
    @lesson = Lesson.find(params[:id])
    course = @lesson.section.course
    @lesson.destroy
    redirect_to instructor_course_path(course)
  end

  # beginning of revised update
  def update
    @lesson = Lesson.find(params[:id])
    @lesson.update_attributes(lesson_params)
    course = @lesson.section.course
    redirect_to instructor_course_path(course)
  end
  # end of revised update - needs to redirect to instructor_course_path


# def update before I started trying to add editing funcitonality to it
  # def update
  #   current_lesson.update_attributes(lesson_params)
  #   render text: 'updated!'
  # end
  # added for editing


  private

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      return render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end
end
