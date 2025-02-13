
class Constants {
  static String popularMovies = '/movie/popular';
  static String topRatedMovies = '/movie/top_rated';
  static String nowPlayingMovies = '/movie/now_playing';
  static String searchMovies = '/search/movie';

  static String getMovieDetailsPath(int id) {
    return "/movie/${id.toString()}";
  }

  static String getMovieVideosPath(int id) {
    return "/movie/${id.toString()}/videos";
  }

  static String handleTmdbImage(String image) {
    return "https://image.tmdb.org/t/p/w200$image";
  }

  static String videoUrl(String key) {
    return "https://www.youtube.com/watch?v=$key";
  }



}



