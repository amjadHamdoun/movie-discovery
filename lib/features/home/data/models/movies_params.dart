

class MoviesParams {
  MoviesParams({
    required this.pageNumber,
    required this.localData
  });

  late final int pageNumber;
  late final bool localData;


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = pageNumber;
    return data;
  }
}
