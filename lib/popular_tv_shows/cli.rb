class PopularTvShows::CLI

  #Start of GEM
  def call

    #Starts scraping process from TV Guide
    PopularTvShows::Scraper.new.make_tv_shows

    puts "Welcome to the Most Popular TV Shows!"

    list_shows
    info_page
    close_app
  end

  def list_shows
    puts ""
    index = 0
    while index <= 46
      puts "#{(index + 1).to_s.ljust(1)}. #{(PopularTvShows::TvShows.all[index].name).ljust(30)} #{(index + 2).to_s.rjust(1)}. #{(PopularTvShows::TvShows.all[index + 1].name).rjust(1)}"
      index += 2
    end
    puts "49 #{PopularTvShows::TvShows.all[48].name}"
    puts ""
  end

  ##Gets user input to pick a particular TV show
  def info_page
    input = nil
    while input != "exit"
      puts "Enter the number of the TV show you would like info on (type 'list' to reprint list or 'exit' to exit):"
      input = gets.strip.downcase

      if input.to_i.between?(1,49)
        show = PopularTvShows::TvShows.all[input.to_i - 1]
        PopularTvShows::TvShows.tv_show_attributes(show)
        print_show_profile(show)
      elsif input == "list"
        list_shows
      elsif input != "exit"
        puts "Invalid entry. Type list or exit"
      end
    end
  end

  #Prints TV Show profile to CLI
  def print_show_profile(show)
    puts ""
    puts "-------------------------------------------"
    puts "| #{show.name} |"
    puts "| #{show.premier_year} #{show.rating} |"
    puts "| #{show.airing} |"
    puts ""
    puts "| Summary: "
    puts "|    #{show.summary}"
    puts ""
    puts "| Main Cast: "

    show.main_cast.each do |member|
      puts "    #{member} "
    end
    puts "-------------------------------------------"
    puts ""
  end

  def close_app
    puts ""
    puts "Thanks for checking out the Most Popular TV Shows!"
  end
end
