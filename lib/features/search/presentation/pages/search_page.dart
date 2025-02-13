import 'package:auto_route/annotations.dart';
import 'package:fh/core/shared/presentation/widgets/app_error_widget.dart';
import 'package:fh/core/shared/presentation/widgets/search_text_field.dart';
import 'package:fh/features/search/presentation/widgets/movie_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../injection.dart';
import '../bloc/search_bloc.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  final SearchBloc _bloc= sl<SearchBloc>();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      _bloc.add(LoadMoreMoviesEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: PreferredSize(preferredSize: Size.fromHeight(40.h),
              child: Padding(
                padding:  EdgeInsets.all(12.0.r),
                child: SearchTextField(
                  hint: 'Search',
                  isOfflineSearch: false,
                  onSearchStringChanged: (keyWord){
                    _bloc.add(SearchMoviesEvent(keyWord));
                  },
                  fieldColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),),
          title:  Text('Search Movies',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.white
        ),
      )),
      body: BlocBuilder<SearchBloc, SearchState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return AppErrorWidget(error: state.error);
          } else if (state is SearchSuccess) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.movies.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index < state.movies.length) {
                  return MovieListTileWidget(movie: state.movies[index], onTap: () {  },);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }
          return const Center(child: Text("Search for a movie"));
        },
      ),
    );
  }
}
