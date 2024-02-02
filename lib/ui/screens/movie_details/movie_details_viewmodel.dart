import 'package:intl/intl.dart';
import 'package:tentwenty_assignment/core/data_models/genera.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/services/api_service.dart';
import 'package:tentwenty_assignment/core/utils/api_endpoints.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';
import 'package:tentwenty_assignment/core/utils/locator.dart';

class MovieDetailsViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();

  List<Genre> allGeneres = [];
  List<Genre> movieGenres = [];

  bool isLoadingGenres = false;
  bool isTrailorLoading = false;

  String? trailorKey;

  MovieDetailsViewModel({required Movie movie}) {
    fetchAllGenres();
    fetchMovieTrailer(movie.id);
  }

  fetchAllGenres() async {
    isLoadingGenres = true;
    notifyListeners();

    final response = await _apiService.get(endPoint: ApiEndPoints.generas);
    if (response != null) {
      response.data['genres'].forEach((genre) {
        allGeneres.add(Genre.fromMap(genre));
      });
    } else {
      // NO GENERA COULD BE FETCHED!
    }

    isLoadingGenres = false;
    notifyListeners();
  }

  fetchMovieTrailer(int movieId) async {
    isTrailorLoading = true;
    notifyListeners();

    final response = await _apiService.get(
      endPoint: "movie/$movieId/videos",
    );
    if (response != null) {
      if (response.data['results'].length > 0) {
        isTrailorLoading = false;
        trailorKey = response.data['results'][0]['key'];
      }

      isTrailorLoading = false;
      notifyListeners();
    }
    return null;
  }

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(date);
  }
}
