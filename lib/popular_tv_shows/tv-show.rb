class PopularTvShows::TvShows
  attr_accessor :name, :airing, :index, :tv_show_url, :premier_year, :rating, :summary, :main_cast
  @@all = []

  #Initializes each object with name, airing date, index, url
  def initialize(name, airing, index, tv_show_url)
    @name = name
    @airing = airing
    @index = index
    @tv_show_url = tv_show_url
    @@all << self
  end

  #iterates over @@all and fills in attributes for each object
  def self.tv_show_attributes(show)
    #@@all.each do |show|

      ##TV Show specific profile page to get attributes
      tv_show_profile = Nokogiri::HTML(open(show.tv_show_url))

      ##check for valid premier year
      if (tv_show_profile.css('ul li.tvobject-masthead-subhead-item')[0] != nil)
        show.premier_year = tv_show_profile.css('ul li.tvobject-masthead-subhead-item')[0].text
      else
        show.premier_year = "N/A"
      end

      ##check for valid rating
      if (tv_show_profile.css('ul li.tvobject-masthead-subhead-item')[2] != nil)
        show.rating = tv_show_profile.css('ul li.tvobject-masthead-subhead-item')[2].text
      else
        show.rating = "N/A"
      end

      ##check for valid summary
      if (tv_show_profile.css('p.tvobject-masthead-description-text') != nil || tv_show_profile.css('p.tvobject-masthead-description-text') != "")
        show.summary = tv_show_profile.css('p.tvobject-masthead-description-text').text.strip
      else
        show.summary = "N/A"
      end


      ##Creates Cast List
      cast_list = []
      cast_list_noko = tv_show_profile.css('#content > div.content-main-right-rail-row > div.content-right-rail > div:nth-child(2) > div.row a > span')

      cast_list_noko.each do |member|
        cast_list << "#{member.text.split[0]} #{member.text.split[1]}"
      end
      show.main_cast = cast_list
    #end
  end

  def self.all
    @@all
  end
end
