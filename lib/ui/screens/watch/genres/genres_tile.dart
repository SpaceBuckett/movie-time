import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/data_models/genera.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/common_widgets/shimmer.dart';
import 'package:tentwenty_assignment/ui/screens/watch/genres/genres_viewmodel.dart';

class GenreTile extends StatelessWidget {
  const GenreTile({required this.genre, super.key});
  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GenreTileViewModel(genre: genre),
      child: Consumer<GenreTileViewModel>(
        builder: (context, model, child) => Stack(
          children: [
            model.isLoadingImage
                ? Shimmer(
                    height: 100.h,
                    width: 163.w,
                  )
                : model.genreImageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: model.genreImageUrl!,
                        fit: BoxFit.fill,
                        height: 100.h,
                        width: 163.w,
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Shimmer();
                        },
                      )
                    : Container(
                        color: kBlueColor.withOpacity(0.6),
                      ),
            const ShadowOverlay(),
            Positioned(
              top: 60.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  genre.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: kPoppins500s16px,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShadowOverlay extends StatelessWidget {
  const ShadowOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 163.w,
          height: 40.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF000000), // 100% black
                Colors.transparent, // 0% color (transparent)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
