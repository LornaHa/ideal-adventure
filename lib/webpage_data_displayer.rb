require 'webpage_data_processor'

class WebpageDataDisplayer

  attr_accessor :processor

  def initialize(file_name)
    @processor = WebpageDataProcessor.new(file_name)
    processor.run
  end

  def display_page_visits_ordered_by_total_visit_count
    page_visits_ordered_by_total_visit_count
    display = ""
    processor.page_visits.each do |visits_record|
      display += "#{visits_record[:url]} #{visits_record[:total_visits]} visits"
    end
    display
  end

  def display_page_visits_ordered_by_unique_visit_count
    page_visits_ordered_by_unique_visit_count
    display_unique = ""
    processor.page_visits.each do |visits_record|
      display_unique += "#{visits_record[:url]} #{visits_record[:unique_visitors]} unique views"
    end
    display_unique
  end

  def page_visits_ordered_by_total_visit_count
    processor.page_visits.sort_by! { |key, val| -key[:total_visits] }
  end

  def page_visits_ordered_by_unique_visit_count
    page_visits_ordered_alphabetically
    processor.page_visits.sort_by! { |key, val| -key[:unique_visitors] }
  end

  def page_visits_ordered_alphabetically
    processor.page_visits.each do |visits_record|
      processor.page_visits.sort_by! {|key, val| key[:url]}
    end
  end

end
