module SixWaysHelper
  def previous_page
    return previous_chapter unless chapter_number == 1
    return six_ways_start_path if module_number == 1
    quiz_of_previous_module
  end

  def next_page
    return next_chapter unless last_chapter?
    return quiz_of_this_module if @module.quiz?
    start_of_next_module
  end

  def module_number
    @module.module_number
  end

  def module_name
    @module.name
  end

  def previous_module
    CourseModule.find_by_module_number module_number - 1
  end

  def next_module
    CourseModule.find_by_module_number module_number + 1
  end

  def chapter_number
    @chapter.chapter_number
  end

  def quiz_of_previous_module
    six_ways_quiz_path(previous_module.slug)
  end

  def previous_chapter
    six_ways_module_path(@module.slug, chapter_number - 1)
  end

  def last_chapter?
    chapter_number == @module.chapters_count
  end

  def next_chapter
    six_ways_module_path(@module.slug, chapter_number + 1)
  end

  def quiz_of_this_module
    six_ways_quiz_path(@module.slug)
  end

  def quiz_result_title
    return "Great! You scored #{quiz_score}%!" if quiz_score > 80
    return "Not Bad! You scored #{quiz_score}%!" if quiz_score > 50
    "You scored #{quiz_score}%. You can do better!"
  end

  def after_quiz_path
    return six_ways_course_end_path if last_quiz_attempted?
    start_of_next_module
  end

  def last_quiz_attempted?
    current_mooc_student.quiz_attempts.maximum(:course_module_id) == CourseModule.last_module.id
  end

  def start_of_next_module
    six_ways_module_path(next_module.slug, 1)
  end

  def first_chapter_path
    six_ways_module_path(CourseModule.find_by_module_number(1).slug, 1)
  end

  def module_has_quiz_header?
    lookup_context.exists?('quiz_header', ["six_ways/module_#{module_number}"], true)
  end
end
