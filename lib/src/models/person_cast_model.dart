class PersonCast {
  List<Person> persons = new List();

  PersonCast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((element) {
      final person = Person.fromJsonMap(element);
      persons.add(person);
    });
  }
}

class Person {
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  double popularity;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Person({
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.popularity,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Person.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    voteCount = json['vote-count'];
    voteAverage = json['vote-average'];
    title = json['title'];
    releaseDate = json['release-date'];
    originalLanguage = json['original-language'];
    originalTitle = json['original-title'];
    genreIds = json['genre-ids'];
    backdropPath = json['backdrop-path'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['poster-path'];
    popularity = json['popularity'];
    character = json['character'];
    creditId = json['credit-id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  getPersonCastingImage() {
    if (posterPath == null) {
      return 'https://www.pasd.es/wp-content/uploads/2015/12/No-Avatar-High-Definition.jpg';
    }
    return 'https://image.tmdb.org/t/p/original/$posterPath';
  }
}
