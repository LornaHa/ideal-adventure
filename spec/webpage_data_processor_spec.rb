require 'webpage_data_processor'

describe WebpageDataProcessor do
  subject { WebpageDataProcessor.new(file_path) }
  let(:file_path) { "../spec/resources/webserver.log" }

  describe '#open_file' do
    it 'loads the whole file' do
      subject.read_file
      expect(subject.webpage_visitors[0]).to eq ({:url=>"/help_page/1", :ip_address=>"126.318.035.038"})
      expect(subject.webpage_visitors[-1]).to eq ({:url=>"/about", :ip_address=>"543.910.244.929"})
    end
  end

  describe '#add_visits_to_webpages' do
    it 'can read the webpage url' do
      add_page_visits_set_up
      expect(subject.webpages_with_visits.select{|x| x[:url] == "/home"}.first[:url]).to eq ("/home")
    end
    it 'can read the ip addresses for each url' do
      add_page_visits_set_up
      expect(subject.webpages_with_visits.select{|x| x[:url] == "/contact"}.first[:ip_address]).to eq ("184.123.665.067")
    end
    it 'can read the visit count for each ip address' do
      add_page_visits_set_up
      expect(subject.webpages_with_visits.select{|x| x[:url] == "/help_page/1"}.first[:visits]).to eq (4)
    end
  end

  describe '#create_url_list' do
    it 'generates a list of unique urls' do
      subject.read_file
      subject.create_url_list
      expect(subject.urls).to eq ["/help_page/1", "/contact", "/home", "/about/2", "/index", "/about"]
    end
  end

  describe '#calculate_page_visits' do
    it 'lists total page visits for each url' do
      page_visits_setup
      expect(subject.page_visits.select{|x| x[:url] == "/contact"}.first[:total_visits]).to eq (89)
    end

    it 'lists unique page visits for each url' do
      page_visits_setup
      expect(subject.page_visits.select{|x| x[:url] == "/home"}.first[:unique_visitors]).to eq (23)
    end
  end

  def page_visits_setup
    subject.read_file
    subject.add_visits_to_webpages
    subject.create_url_list
    subject.sum_page_visits
  end

  def add_page_visits_set_up
    subject.read_file
    subject.add_visits_to_webpages
  end
end
