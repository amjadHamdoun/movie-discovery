import 'package:auto_route/auto_route.dart';
import 'package:fh/core/router/auto_router.dart';
import 'package:fh/core/shared/presentation/bloc/app_bloc.dart';
import 'package:fh/core/theme/app_colors.dart';
import 'package:fh/features/home/presentation/widgets/now_playing_movies_widget.dart';
import 'package:fh/features/home/presentation/widgets/popular_movies_widget.dart';
import 'package:fh/features/home/presentation/widgets/top_rated_movies_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/presentation/widgets/app_error_widget.dart';
import '../../../../injection.dart';
import '../bloc/movies_bloc.dart';


@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final MoviesBloc _bloc = sl<MoviesBloc>();
  final AppBloc appBloc = sl<AppBloc>();

  Future<void> _onRefresh() async {
    callGetMovies();
  }
  callGetMovies ()=> _bloc.add(const OnGettingMoviesEvent(pageNumber: 1),);

  @override
  void initState() {
    callGetMovies();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return  BlocConsumer<MoviesBloc,MoviesState>(
      bloc: _bloc,
      listener: (context, state) {
        // if(state is ErrorGetMoviesState){
        //   ToastShower().showToast(state.errorMsg, ToastType.error, context);
        // }
      },
      builder: (context, state) {
        return  Scaffold(
            appBar: AppBar(
              title: Text('Movie Discovery',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.white
              ),),
              actions: [
                IconButton(onPressed: (){
                  getAppRouter.push(const SearchRoute());
                }, icon: Icon(Icons.search,
                  color: AppColors.white,
                  size: 25.sp,)),
                IconButton(onPressed: (){
                  getAppRouter.push( ShowAllMoviesRoute(title: "Favorites",
                      movies:state is SuccessGetMoviesState? state.favoriteMovies:[]));
                }, icon: Icon(Icons.favorite_outline_sharp,
                  color: AppColors.white,
                  size: 25.sp,)),

                IconButton(onPressed: (){
                  appBloc.add(ToggleThemeEvent());
                }, icon: Icon(Icons.dark_mode_outlined,
                  color: AppColors.white,
                  size: 25.sp,)),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              child: state is ErrorGetMoviesState?
              Expanded(child: AppErrorWidget(error: state.type, onPressed: _onRefresh)):
              SingleChildScrollView(
                child: Column(
                  children: [
                    PopularMoviesWidget(bloc: _bloc,title: 'Popular Movies',),
                    NowPlayingMoviesWidget(bloc: _bloc,title: 'Now Playing Movies',),
                    TopRatedMoviesWidget(bloc: _bloc,title: 'Top Rated Movies',),
                    // ],

                  ],
                ),
              ),
            ));
      },

    );
  }
}
