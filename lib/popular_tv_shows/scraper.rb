class PopularTvShows::Scraper

  def get_page
    Nokogiri::HTML(open('http://www.tvguide.com/tvshows/'))
  end

  def scrape_tv_show_index
    self.get_page.css('div.most-popular-grid-item')
  end

  #Creates each TV show object after scraping for list
  def make_tv_shows
    scrape_tv_show_index.each {|tv_show| PopularTvShows::TvShows.new(tv_show)}
    PopularTvShows::TvShows.tv_show_attributes
  end

end
