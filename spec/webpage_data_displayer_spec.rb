require 'webpage_data_displayer'

describe WebpageDataDisplayer do
  subject { described_class.new(file_path) }
  let(:file_path) { "../spec/resources/webserver.log" }

  describe '#page_visits_ordered_by_total_visit_count' do
    it 'webpages ordered by their total visit count from highest to lowest' do
      expect(subject.page_visits_ordered_by_total_visit_count.select{|x| x[:total_visits] == 90})
      .to eq ([{:url=>"/about/2", :total_visits=>90, :unique_visitors=>22}])
    end
  end

  describe '#page_visits_ordered_by_unique_visit_count' do
    it 'webpages ordered into alphabetical order' do
      expect(subject.page_visits_ordered_alphabetically)
      .to eq ([{:url=>"/about", :total_visits=>81, :unique_visitors=>21},
        {:url=>"/about/2", :total_visits=>90, :unique_visitors=>22},
        {:url=>"/contact", :total_visits=>89, :unique_visitors=>23},
        {:url=>"/help_page/1", :total_visits=>80, :unique_visitors=>23},
        {:url=>"/home", :total_visits=>78, :unique_visitors=>23},
        {:url=>"/index", :total_visits=>82, :unique_visitors=>23}])
    end
    it 'then webpages ordered by their unique visits from highest to lowest' do
      expect(subject.page_visits_ordered_by_unique_visit_count.select{|x| x[:unique_visitors] == 23})
      .to eq ([{:url=>"/contact", :total_visits=>89, :unique_visitors=>23},
        {:url=>"/help_page/1", :total_visits=>80, :unique_visitors=>23},
        {:url=>"/home", :total_visits=>78, :unique_visitors=>23},
        {:url=>"/index", :total_visits=>82, :unique_visitors=>23}])
    end
  end

  describe '#display_page_visits_ordered_by_total_visit_count' do
    it 'displays page visits from most viewed to least viewed' do
      expect(subject.display_page_visits_ordered_by_total_visit_count)
      .to eq ("/about/2 90 visits" "/contact 89 visits" "/index 82 visits" "/about 81 visits" "/help_page/1 80 visits" "/home 78 visits")
    end
  end

  describe '#display_page_visits_ordered_by_unique_visit_count' do
    it 'displays unique page views from most viewed to least viewed' do
      expect(subject.display_page_visits_ordered_by_unique_visit_count)
      .to eq ("/contact 23 unique views" "/help_page/1 23 unique views" "/home 23 unique views" "/index 23 unique views" "/about/2 22 unique views" "/about 21 unique views")
    end
  end
end
