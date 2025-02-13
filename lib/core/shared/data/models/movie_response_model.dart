
class ApiResponse<T> {
  ApiResponse({
    required this.totalPages,
    required this.results,
    required this.page,
    required this.totalResults
  });

  late final int? totalResults;
  late final int? page;
  late final int? totalPages;
  late final T? results;


  static fromJson<T>(Map<dynamic, dynamic> json, Function tFromJson) {
    return ApiResponse<T>(
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      results: tFromJson(json['results']),
      page: json['page'],

    );
  }

}
