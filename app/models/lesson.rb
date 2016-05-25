class Lesson < ActiveRecord::Base

	belongs_to :section
	#mount_uploader :video, VideoUploader

  def video
    	"https://firehose-lessons-ken.s3.amazonaws.com/uploads/lesson/video/1/SampleVideo_1280x720_1mb.mp4"
  end

	  include RankedModel
	  ranks :row_order, :with_same => :section_id

  def next_lesson
    lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first

    if lesson.blank? && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end
    return lesson
  end
end
