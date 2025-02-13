

class SearchParams {
  SearchParams({
    required this.pageNumber,
    required this.query
  });

  late final int pageNumber;
  late final String query;


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = pageNumber;
    data['query'] = query;
    return data;
  }
}
