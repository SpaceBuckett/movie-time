import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tentwenty_assignment/core/constants/base_urls.dart';
import 'package:tentwenty_assignment/core/data_models/genera.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/services/api_service.dart';
import 'package:tentwenty_assignment/core/utils/api_endpoints.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';
import 'package:tentwenty_assignment/core/utils/locator.dart';

class WatchViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();

  final PagingController<int, Movie> moviesPagingController =
      PagingController<int, Movie>(
    firstPageKey: 1,
  );
  bool showGenres = false;
  bool isLoadingGenres = false;

  List<Genre> allGenres = [];

  WatchViewModel() {
    init();
  }

  init() {
    fetchUpcomingMoviesPage(1);
    fetchAllGenres();
  }

  fetchUpcomingMoviesPage(int page) async {
    final response = await _apiService
        .get(endPoint: ApiEndPoints.comingMovies, params: {"page": page});
    if (response != null) {
      List<Movie> newMovies = [];
      int totalPages = response.data['total_pages'];
      response.data['results'].forEach((movie) {
        newMovies.add(Movie.fromMap(movie));
      });
      final isLastPage = page == totalPages;

      if (isLastPage) {
        moviesPagingController.appendLastPage(newMovies);
      } else {
        final nextPageKey = page + 1;
        moviesPagingController.appendPage(newMovies, nextPageKey);
      }
    }
  }

  Future<List<String>?> getMovieImages(int movieId) async {
    List<String> images = [];
    final response = await _apiService.get(endPoint: "movie/$movieId/images");
    if (response != null) {
      if (response.data['backdrops'].length > 0) {
        response.data['backdrops'].forEach(
          (backdrop) {
            images.add(baseUrl + backdrop['file_path']);
          },
        );
        return images;
      } else {
        return [];
      }
    } else {
      return null;
    }
  }

  fetchAllGenres() async {
    isLoadingGenres = true;
    notifyListeners();

    final response = await _apiService.get(endPoint: ApiEndPoints.generas);
    if (response != null) {
      response.data['genres'].forEach((genre) {
        allGenres.add(
          Genre.fromMap(genre),
        );
      });
    }

    print('LENGTH: ${allGenres.length}');

    isLoadingGenres = false;
    notifyListeners();
  }

  toggleGenre() {
    showGenres = !showGenres;
    notifyListeners();
  }
}
