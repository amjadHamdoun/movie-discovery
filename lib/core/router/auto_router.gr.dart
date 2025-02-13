// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MovieDetailsPage]
class MovieDetailsRoute extends PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    Key? key,
    required int movieId,
    List<PageRouteInfo>? children,
  }) : super(
          MovieDetailsRoute.name,
          args: MovieDetailsRouteArgs(
            key: key,
            movieId: movieId,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailsRouteArgs>();
      return MovieDetailsPage(
        key: args.key,
        movieId: args.movieId,
      );
    },
  );
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({
    this.key,
    required this.movieId,
  });

  final Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, movieId: $movieId}';
  }
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchPage();
    },
  );
}

/// generated route for
/// [ShowAllMoviesPage]
class ShowAllMoviesRoute extends PageRouteInfo<ShowAllMoviesRouteArgs> {
  ShowAllMoviesRoute({
    Key? key,
    required String title,
    required List<MovieEntity> movies,
    List<PageRouteInfo>? children,
  }) : super(
          ShowAllMoviesRoute.name,
          args: ShowAllMoviesRouteArgs(
            key: key,
            title: title,
            movies: movies,
          ),
          initialChildren: children,
        );

  static const String name = 'ShowAllMoviesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowAllMoviesRouteArgs>();
      return ShowAllMoviesPage(
        key: args.key,
        title: args.title,
        movies: args.movies,
      );
    },
  );
}

class ShowAllMoviesRouteArgs {
  const ShowAllMoviesRouteArgs({
    this.key,
    required this.title,
    required this.movies,
  });

  final Key? key;

  final String title;

  final List<MovieEntity> movies;

  @override
  String toString() {
    return 'ShowAllMoviesRouteArgs{key: $key, title: $title, movies: $movies}';
  }
}
