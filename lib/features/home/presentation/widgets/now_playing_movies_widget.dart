

import 'package:fh/core/router/auto_router.dart';
import 'package:fh/core/shared/presentation/widgets/app_loader.dart';
import 'package:fh/features/home/presentation/bloc/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'head_section_widget.dart';
import 'movie_card_widget.dart';

class NowPlayingMoviesWidget extends StatelessWidget {
  final String title;
  final MoviesBloc bloc;

  const NowPlayingMoviesWidget({super.key, required this.bloc , required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadingGetMoviesState) {
          return  AppLoader(
            height: 235.h,
            axis: Axis.horizontal,
            count: 6,
          );
        } else if (state is SuccessGetMoviesState) {
          return Column(
            children: [
              HeadSectionWidget(
                voidCallback: (){
                  getAppRouter.push(ShowAllMoviesRoute(title: title, movies: state.nowPlayingMovies));
                },
                title: title,
                buttonText: 'View All',
              ),
              SizedBox(
                height: 235.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.nowPlayingMovies.length>10 ? 10:state.nowPlayingMovies.length,
                  itemBuilder: (context, index) {
                    return MovieCardWidget(movie: state.nowPlayingMovies[index],
                       addToFavorite: ()=>bloc.add(OnAddFavoriteMovieEvent(state.nowPlayingMovies[index])),
                      removeFromFavorite: ()=>bloc.add(OnRemoveFavoriteMovieEvent(state.nowPlayingMovies[index])),
                      isFavorite: state.favoriteMovies.any((element) => element.movieId==state.nowPlayingMovies[index].movieId,),
                    );
                  },
                ),
              ),
            ],
          );
        } else{
          return const SizedBox();
        }
      },
    );
  }
}
