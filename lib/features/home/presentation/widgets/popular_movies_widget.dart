

import 'package:fh/core/shared/presentation/widgets/app_loader.dart';
import 'package:fh/features/home/presentation/bloc/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/router/auto_router.dart';
import 'head_section_widget.dart';
import 'movie_card_widget.dart';

class PopularMoviesWidget extends StatelessWidget {
  final MoviesBloc bloc;
  final String title;

  const PopularMoviesWidget({super.key, required this.bloc , required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MoviesBloc, MoviesState>(
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
                      getAppRouter.push(ShowAllMoviesRoute(title: title, movies: state.popularMovies));
                    },
                    title: title,
                    buttonText: 'View All',
                  ),
                  SizedBox(
                    height: 235.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.popularMovies.length>10 ? 10:state.popularMovies.length,
                      itemBuilder: (context, index) {
                        return MovieCardWidget(movie: state.popularMovies[index]);
                      },
                    ),
                  ),
                ],
              );
            } else{
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
