class WebpageDataProcessor

  attr_reader :webpage_file, :file_name
  attr_accessor :webpage_visitors, :webpages_with_visits, :urls, :page_visits


  def initialize(file_name)
    @file_name = File.expand_path(file_name, __dir__)
    @webpage_file = open_file
    @webpage_visitors = []
    @urls = []
    @webpages_with_visits = []
    @page_visits = []
  end

  def run
    open_file
    read_file
    add_visits_to_webpages
    create_url_list
    sum_page_visits
  end

  def open_file
    File.open(file_name)
  end

  def read_file
    webpage_file.each do |line|
      data = line.split(/\s/)
      webpage_visitors << { url: data[0], ip_address: data[1]}
    end
  end

  def add_visits_to_webpages
    webpage_visitors.each do |record|
      webpages_with_visits << record.merge(visits: webpage_visitors.count(record))
    end
    webpages_with_visits.uniq!
  end

  def create_url_list
    webpage_visitors.each do |record|
      urls << record[:url]
    end
    urls.uniq!
  end

  def sum_page_visits
    page_visits_setup
    page_visits.each do |visits_record|
      add_visits_to_records(visits_record)
    end
  end

  private

  def add_visits_to_records(visits_record)
    webpages_with_visits.each do |webpages_record|
      if webpages_record[:url] == visits_record[:url]
        visits_record.merge(total_visits: visits_record[:total_visits] += webpages_record[:visits])
        visits_record.merge(unique_visitors: visits_record[:unique_visitors] += 1)
      end
    end
  end

  def page_visits_setup
    urls.each do |url|
      page_visits << { url: url, total_visits: 0, unique_visitors: 0 }
    end
  end
end
