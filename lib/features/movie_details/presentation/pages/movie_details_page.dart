import 'package:auto_route/annotations.dart';
import 'package:fh/core/shared/presentation/widgets/app_error_widget.dart';
import 'package:fh/features/movie_details/presentation/widgets/movie_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../injection.dart';
import '../bloc/movie_details_bloc.dart';


@RoutePage()
class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  final MovieDetailsBloc _bloc = sl<MovieDetailsBloc>();

  @override
  void initState() {
    _bloc.add(FetchMovieDetailsEvent(widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Movie Details",  style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: AppColors.white
      ),)),
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsError) {
            return AppErrorWidget(error: state.error);
          } else if (state is MovieDetailsLoaded) {
            return MovieDetailsBodyWidget(movieDetails: state.movie,videos: state.videos,);
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
