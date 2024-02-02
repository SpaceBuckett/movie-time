import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/trailer_player/trailer_player_viewmodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewTrailorScreen extends StatelessWidget {
  const ViewTrailorScreen({required this.trailorId, super.key});

  final String trailorId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TrailorPlayerViewModel(trailorId: trailorId),
      child: Consumer<TrailorPlayerViewModel>(
        builder: (context, model, child) => Scaffold(
          body: model.isStateBusy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    width: 1.sw,
                    controller: model.trailorPlayerController,
                    showVideoProgressIndicator: true,
                    progressColors: ProgressBarColors(
                      playedColor: kBlueColor,
                      handleColor: kBlueColor.withOpacity(0.7),
                    ),
                    onEnded: (metaData) {
                      model.trailorPlayerController.toggleFullScreenMode();
                    },
                    topActions: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            model.exit();
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  builder: (context, player) {
                    return player;
                  },
                ),
        ),
      ),
    );
  }
}
