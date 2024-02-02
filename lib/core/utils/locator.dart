import 'package:get_it/get_it.dart';
import 'package:tentwenty_assignment/core/services/api_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  locator.registerSingleton(ApiService());
}
