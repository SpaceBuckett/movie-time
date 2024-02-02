import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tentwenty_assignment/core/router/app_router.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailorPlayerViewModel extends BaseViewModel {
  late YoutubePlayerController trailorPlayerController;
  bool backCalled = false;
  bool isStateBusy = false;

  TrailorPlayerViewModel({required String trailorId}) {
    init(trailorId);
  } 

  

  init(String id) async {
    isStateBusy = true;
    notifyListeners();

    trailorPlayerController = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

    isStateBusy = false;
    notifyListeners();
  }

  void exit() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    GoRouter.of(getContext!).pop();
  }

  @override
  void dispose() {
    trailorPlayerController.dispose();
    super.dispose();
  }
}
