import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/constants/genre_colors.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/common_widgets/shimmer.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/movie_details_screen.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/movie_details_viewmodel.dart';

class GeneraSection extends StatelessWidget {
  const GeneraSection({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailsViewModel>(
      builder: (context, model, child) => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(left: 40.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 27.h),
              Text(
                'Genres',
                style: kPoppins500s16px.copyWith(
                  color: kDarkText,
                ),
              ),
              SizedBox(height: 14.h),
              model.isLoadingGenres
                  ? const Shimmer()
                  : Wrap(
                      runSpacing: 7.h,
                      spacing: 7.w,
                      children: movie.genreIds.map((genreId) {
                        var genre = model.allGeneres.firstWhere(
                          (genre) => genre.id == genreId,
                        );
                        return GenreChip(
                          genre: genre,
                          chipColor: genereChipColors[
                              genreId % genereChipColors.length],
                        ).animate().fadeIn();
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
