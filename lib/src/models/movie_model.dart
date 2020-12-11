class Movies {
  List<Movie> items = new List();
  //constructor
  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    //recorremos la lista
    for (var item in jsonList) {
      //instancia de pelicula con los datos de un item
      final movie = new Movie.fromJsonMap(item);
      //añadimos la pelicula con los datos del item en la lista
      items.add(movie);
    }
  }
}

class Movie {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.uniqueId, //id para no repetir id en los Hero widgets
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1; //para pasarlo a double valido;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getMoviePoster() {
    if (posterPath == null) {
      return 'https://www.cumbriaeducationtrust.org/wp-content/uploads/2016/01/placeholder.png';
    }
    return 'https://image.tmdb.org/t/p/original/$posterPath';
  }

  getMovieBackgroundImage() {
    if (backdropPath == null) {
      return 'https://www.cumbriaeducationtrust.org/wp-content/uploads/2016/01/placeholder.png';
    }
    return 'https://image.tmdb.org/t/p/original/$backdropPath';
  }
}
