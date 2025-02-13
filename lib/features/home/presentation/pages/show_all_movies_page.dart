import 'package:auto_route/annotations.dart';
import 'package:fh/core/router/auto_router.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';
import 'package:fh/core/shared/presentation/widgets/app_error_widget.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:fh/features/search/presentation/widgets/movie_list_tile_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

@RoutePage()
class ShowAllMoviesPage extends StatelessWidget {
  final String title;
  final List<MovieEntity> movies;

  const ShowAllMoviesPage({super.key,required this.title,required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  Text(title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.white
        ),
      )),
      body: movies.isNotEmpty? ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
            return MovieListTileWidget(movie: movies[index], onTap: () {
              getAppRouter.push(MovieDetailsRoute(movieId: movies[index].movieId));
            },);

        },
      ):const AppErrorWidget(error: ErrorType.noDataFound),
    );
  }
}
