import 'package:tentwenty_assignment/core/data_models/date_selection.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';

class SeatingViewModel extends BaseViewModel {
  List<Date> availableDates = [
    Date(date: '5 Mar', isActive: false),
    Date(date: '6 Mar', isActive: false),
    Date(date: '7 Mar', isActive: false),
    Date(date: '8 Mar', isActive: false),
    Date(date: '9 Mar', isActive: false),
    Date(date: '10 Mar', isActive: false),
    Date(date: '11 Mar', isActive: false),
  ];

  chooseDate(int index) {
    for (int i = 0; i < availableDates.length; i++) {
      if (i == index) {
        availableDates[i].isActive = true;
      } else {
        availableDates[i].isActive = false;
      }
    }
    notifyListeners();
  }
}
