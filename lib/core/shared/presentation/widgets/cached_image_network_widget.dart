import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/assets.dart';

class CachedImageNetworkWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageUrl;
  final double? radius;
  final GlobalKey _backgroundImageKey = GlobalKey();

  CachedImageNetworkWidget({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Container(
        decoration: radius == null
            ? null
            : BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
        height: height,
        width: width,
        child: imageUrl != null && imageUrl != ""
            ? CachedNetworkImage(
          key: _backgroundImageKey,
          imageUrl: imageUrl ?? "",
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: height,
              width: width,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            Assets.logo,
            fit: BoxFit.contain,
          ),
        )
            : Image.asset(
          Assets.logo,
          height: height,
          width: width,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
