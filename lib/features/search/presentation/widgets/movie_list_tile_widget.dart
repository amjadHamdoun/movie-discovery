
import 'package:flutter/material.dart';
import 'package:fh/core/shared/domin/entities/movie_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/shared/presentation/widgets/cached_image_network_widget.dart';

class MovieListTileWidget extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback onTap;

  const MovieListTileWidget({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin:  EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.h),
      child: ListTile(
        contentPadding:  EdgeInsets.all(12.r),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CachedImageNetworkWidget(
            imageUrl: Constants.handleTmdbImage(movie.image ?? ''),
            width: 60.r,
            height: 90.h,
          ),
        ),
        title: Text(
          movie.movieTitle??'',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text(
              movie.rate.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing:  Icon(Icons.arrow_forward_ios, size: 24.sp),
        onTap: onTap,
      ),
    );
  }
}
