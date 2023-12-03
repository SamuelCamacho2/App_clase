class PopularModel {
  String? backdropPath;
  int? id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;

  PopularModel({
    this.backdropPath,
    this.id,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
  });

  factory PopularModel.fromMap(Map<String,dynamic> map){
    return PopularModel(
      backdropPath: map['backdrop_path'] ?? '',
      id: map['id'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'] ?? '',
      voteAverage: (map['vote_average'] is int)
        ?(map['vote_average'] as int).toDouble()
        :map['vote_average']
    );
  }
}
