class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final List<dynamic> genres;
  final String overview;
  final String posterPath;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.genres,
    required this.overview,
    required this.posterPath, 
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      genres: json['genre_ids'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'],
    );
  }
}