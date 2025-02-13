import 'package:fh/core/constants/constants.dart';
import 'package:fh/core/utils/extensions.dart';
import 'package:fh/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:fh/features/movie_details/domain/entities/video_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/shared/presentation/widgets/cached_image_network_widget.dart';
import '../../../../core/theme/app_colors.dart';

class MovieDetailsBodyWidget extends StatelessWidget {
  final MovieDetailsEntity movieDetails;
  final List<VideoEntity> videos;
  final VoidCallback? onToggleFavorite;
  final bool isFavorite;

  const MovieDetailsBodyWidget({
    super.key,
    required this.movieDetails,
    required this.videos,
     this.onToggleFavorite,
     this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: CachedImageNetworkWidget(
                  imageUrl: Constants.handleTmdbImage(movieDetails.image ?? ""),
                  width: 1.sw,
                  height: 300.h,
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
                    icon: Icon(
                       Icons.favorite,
                      color: isFavorite ? AppColors.red : AppColors.grey,
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            movieDetails.movieTitle ?? "",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              SizedBox(width: 4.w),
              Text(
                '${movieDetails.rate} / 10',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Release Date: ${movieDetails.movieReleaseDate.dayFormat}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Genres: ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(
                child: Text(
                  movieDetails.movieGenres.map((g) => g.name).join(", "),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            movieDetails.movieOverview ?? "",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16.h),
          Text(
            "Production Companies:",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: movieDetails.movieProductionCompanies
                .map((company) => Text(
              "- ${company.name}",
              style: Theme.of(context).textTheme.bodyMedium,
            ))
                .toList(),
          ),
          SizedBox(height: 16.h),
          if (videos.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Movie Videos:",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                ...videos.map(
                      (video) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: GestureDetector(
                      onTap: () async => await launchUrl(
                        Uri.parse(Constants.videoUrl(video.key)),
                      ),
                      child: Text(
                        video.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
