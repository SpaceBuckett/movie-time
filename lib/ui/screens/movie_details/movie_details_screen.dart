import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/constants/base_urls.dart';
import 'package:tentwenty_assignment/core/data_models/genera.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/router/app_routes.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/common_widgets/custom_elevated_button.dart';
import 'package:tentwenty_assignment/ui/common_widgets/custom_outline_button.dart';
import 'package:tentwenty_assignment/ui/common_widgets/genere_widget.dart';
import 'package:tentwenty_assignment/ui/common_widgets/movie_overview_widget.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/movie_details_viewmodel.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsViewModel(
        movie: movie,
      ),
      child: Consumer<MovieDetailsViewModel>(
        builder: (context, model, child) => Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CustomSliverAppBar(
                movie: movie,
              ),
              GeneraSection(movie: movie),
              const SliverDivider(),
              OverviewSection(movie: movie),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.movie,
    super.key,
  });
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        movie.backdropPath != null ? baseUrl + movie.backdropPath! : '';
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      automaticallyImplyLeading: false,
      expandedHeight: 466.0.h,
      flexibleSpace: Stack(
        children: [
          Hero(
            tag: imageUrl,
            transitionOnUserGestures: true,
            child: CachedNetworkImage(
              height: 495.h,
              width: double.infinity,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kBlueColor,
                    value: progress.progress,
                  ),
                );
              },
            ),
          ),
          const ShadowOverlay(),
          const BackButton(),
          ReleaseDateTicketsAndTrailerButtons(movie: movie),
        ],
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
      bottom: 0,
      child: Container(
        width: 1.sw,
        height: 459.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF000000).withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDivider extends StatelessWidget {
  const SliverDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(40.w, 22.h, 40.w, 15.h),
        child: Divider(
          color: Colors.black.withOpacity(0.05),
        ),
      ),
    );
  }
}

class ReleaseDateTicketsAndTrailerButtons extends StatelessWidget {
  const ReleaseDateTicketsAndTrailerButtons({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailsViewModel>(
      builder: (context, model, child) => Align(
        alignment: Alignment.center,
        child: FittedBox(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 287.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'In Theaters ${model.formatDate(movie.releaseDate)}',
                    style: kPoppins500s16px,
                  ),
                  SizedBox(height: 15.h),
                  CustomElevatedButton(
                    buttonTitle: 'Get Tickets',
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRoutes.seatMapping,
                        extra: {
                          'movie': movie,
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  model.isTrailorLoading
                      ? CircularProgressIndicator(
                          color: kBlueColor,
                        )
                      : CustomOutlineButton(
                          buttonTitle: 'Watch Trailer',
                          iconUrl: 'assets/icons/play-button-icon.png',
                          onTap: () {
                            if (model.trailorKey != null) {
                              GoRouter.of(context).push(
                                AppRoutes.viewTrailor,
                                extra: {
                                  'trailorId': model.trailorKey,
                                },
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 59.h,
      left: 13.w,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pop();
        },
        child: Row(
          children: [
            Image.asset(
              'assets/icons/back-icon.png',
              height: 30.h,
              width: 30.h,
            ),
            SizedBox(width: 15.w),
            Text(
              'Watch',
              style: kPoppins500s16px,
            ),
          ],
        ),
      ),
    );
  }
}

class GenreChip extends StatelessWidget {
  const GenreChip({
    required this.genre,
    required this.chipColor,
    super.key,
  });

  final Genre genre;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: chipColor,
      ),
      child: Text(
        genre.name,
        style: kPoppins600s14px.copyWith(
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
