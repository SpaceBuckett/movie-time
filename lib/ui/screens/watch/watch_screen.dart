import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/constants/base_urls.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/router/app_routes.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/screens/watch/watch_viewmodel.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WatchViewModel(),
      child: Consumer<WatchViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: kScaffoldBackground,
          appBar: _topBar(),
          body: const MoviesList(),
        ),
      ),
    );
  }

  AppBar _topBar() {
    return AppBar(
      toolbarHeight: 83.h,
      flexibleSpace: Container(
        height: 111.h,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.w, bottom: 24.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watch',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF202C43),
                  ),
                ),
                Image.asset(
                  'assets/icons/search-icon.png',
                  height: 36.h,
                  width: 36.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchViewModel>(
      builder: (context, model, child) => PagedListView.separated(
        pagingController: model.moviesPagingController,
        padding: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 30.h),
        physics: const BouncingScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
          itemBuilder: (context, movie, index) {
            return MovieTile(
              movie: movie,
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Center(
              child: Text(
                "Opps, something is not right!",
                style: kBody,
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: Text(
              "Sorry, no new upcoming movies!",
              style: kBody,
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        movie.backdropPath != null ? imageBaseUrl + movie.backdropPath! : '';
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
          AppRoutes.movieDetails,
          extra: {
            'movie': movie,
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Stack(
          children: [
            Hero(
              tag: imageUrl,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
                height: 180.h,
                width: 335.w,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  );
                },
              ),
            ),
            const ShadowOverlay(),
            Title(
              title: movie.originalTitle,
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
      top: 110.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 335.w,
          height: 70.h,
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

class Title extends StatelessWidget {
  const Title({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 137.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: kPoppins500s18px,
        ),
      ),
    );
  }
}
