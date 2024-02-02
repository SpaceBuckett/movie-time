import 'dart:math';

import 'package:tentwenty_assignment/core/constants/base_urls.dart';
import 'package:tentwenty_assignment/core/data_models/genera.dart';
import 'package:tentwenty_assignment/core/services/api_service.dart';
import 'package:tentwenty_assignment/core/utils/api_endpoints.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';
import 'package:tentwenty_assignment/core/utils/locator.dart';

class GenreTileViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();

  String? genreImageUrl;
  bool isLoadingImage = false;

  GenreTileViewModel({required Genre genre}) {
    fetchGenreTileImage(genre);
  }

  fetchGenreTileImage(Genre genre) async {
    isLoadingImage = true;
    notifyListeners();

    var response = await _apiService.get(
        endPoint: ApiEndPoints.genreImage,
        params: {
          'with_genres': genre.name,
          'sort_by': 'popularity.desc',
          'page': 1
        });
    if (response != null) {
      var result = response.data['results'];
      print('Result: $result');
      var imagePath = result[Random().nextInt(result.length)]['backdrop_path'];
      genreImageUrl = baseUrl + imagePath;
    }

    print('Image path: $genreImageUrl');

    isLoadingImage = false;
    notifyListeners();
  }
}
