class PopularTvShows::Scraper

  def get_page
    Nokogiri::HTML(open('http://www.tvguide.com/tvshows/'))
  end

  def scrape_tv_show_index
    self.get_page.css('div.most-popular-grid-item')
  end

  #Creates each TV show object after scraping for list
  def make_tv_shows
    scrape_tv_show_index.each do |tv_show|
      name = tv_show.css('h2.most-popular-item-title a').text
      airing = tv_show.css('span.most-popular-item-information').text.strip
      index = tv_show.css('span.most-popular-item-show-card-overlay-number').text.to_i
      tv_show_url = tv_show.css('h2.most-popular-item-title a').attribute('href').value
      PopularTvShows::TvShows.new(name, airing, index, tv_show_url)
    end
    #PopularTvShows::TvShows.tv_show_attributes
  end

end
