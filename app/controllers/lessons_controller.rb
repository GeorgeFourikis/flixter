class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_lesson
	def show

	end

	private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_lesson
  	if current_lesson.section.course.user != current_user.enrolled_in?(@course)
  		redirect_to courses_path(@course), alert:'You are not enrolled,you cannot see the lesson!'
    else
    	redirect_to lessons_path(@lesson)
  	end
  end

end
