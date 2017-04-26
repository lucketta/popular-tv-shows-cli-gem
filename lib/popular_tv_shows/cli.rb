class PopularTvShows::CLI

  def call

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

  def info_page
    input = nil
    while input != "exit"
      puts "Enter the number of the TV show you would like info on (type 'list' to reprint list or 'exit' to exit):"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i < 50
        print_show_profile(input.to_i - 1)
      elsif input == "list"
        list_shows
      else
        puts "Invalid entry. Type list or exit"
      end
    end
  end

  def print_show_profile(index)
    puts ""
    puts "-------------------------------------------"
    puts "| #{PopularTvShows::TvShows.all[index].name} |"
    puts "| #{PopularTvShows::TvShows.all[index].premier_year} #{PopularTvShows::TvShows.all[index].rating} |"
    puts "| #{PopularTvShows::TvShows.all[index].airing} |"
    puts ""
    puts "| Summary: "
    puts "|    #{PopularTvShows::TvShows.all[index].summary}"
    puts ""
    puts "| Main Cast: "

    PopularTvShows::TvShows.all[index].main_cast.each do |member|
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
