import 'package:auto_route/auto_route.dart';
import 'package:fh/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:fh/injection.dart';
import 'package:flutter/cupertino.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/show_all_movies_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../shared/domin/entities/movie_entity.dart';

part 'auto_router.gr.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true,),
        AutoRoute(page: MovieDetailsRoute.page,),
        AutoRoute(page: SearchRoute.page),
         AutoRoute(page: ShowAllMoviesRoute.page),

  ];
}



AppRouter getAppRouter =sl<AppRouter>();
