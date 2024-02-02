import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/ui/screens/watch/genres/genres_tile.dart';
import 'package:tentwenty_assignment/ui/screens/watch/watch_viewmodel.dart';

class AllGenresView extends StatelessWidget {
  const AllGenresView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchViewModel>(
      builder: (context, model, child) => GridView.builder(
        itemCount: model.allGenres.length,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5.w,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: GenreTile(
              genre: model.allGenres[index],
            ),
          );
        },
      ),
    );
  }
}
