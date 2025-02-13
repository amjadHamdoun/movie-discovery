import 'package:fh/core/router/auto_router.dart';
import 'package:fh/core/shared/presentation/widgets/cached_image_network_widget.dart';
import 'package:fh/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/shared/domin/entities/movie_entity.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieEntity movie;
  final bool isFavorite;
  final VoidCallback addToFavorite;
  final VoidCallback removeFromFavorite;

   const MovieCardWidget({super.key, required this.movie , required this.isFavorite,
    required this.addToFavorite, required this.removeFromFavorite
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getAppRouter.push(MovieDetailsRoute(movieId: movie.movieId));
      },
      child: Container(
        width: 160.r,
        margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: CachedImageNetworkWidget(
                    imageUrl: Constants.handleTmdbImage(movie.image ?? ''),
                    height: 155.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white
                    ),
                    child: IconButton(
                      onPressed:isFavorite ? removeFromFavorite:addToFavorite,
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorite ? AppColors.red : AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.movieTitle ?? "Unknown",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18.r),
                      SizedBox(width: 4.w),
                      Text(
                        movie.rate.toString() ,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
