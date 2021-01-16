module MoviesHelper
  def average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No Reviews")
    else
      "*" * movie.average_stars.round
    end
  end

  def gross(movie)
    movie.flop? ? "Flop!" : number_to_currency(movie.total_gross, precision: 0)
  end

  def movie_image(movie)
    if movie.movie_image.attached? 
      image_tag(movie.movie_image.variant(resize_to_limit: [150, nil]))
    else
      image_tag("placeholder.png")
    end
  end

  def year_of(movie)
    movie.released_on&.year
  end
  
  def nav_link_to(movie_filter, url)
    if current_page?(url)
      link_to movie_filter, url, class: "active"
    else
      link_to movie_filter, url
    end
  end
end
