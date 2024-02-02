import 'dart:math';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_assignment/core/data_models/date_selection.dart';
import 'package:tentwenty_assignment/core/data_models/hall_selection.dart';
import 'package:tentwenty_assignment/core/data_models/seat_number.dart';
import 'package:tentwenty_assignment/core/router/app_router.dart';
import 'package:tentwenty_assignment/core/router/app_routes.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';

class SeatingViewModel extends BaseViewModel {
  List<CinemaHall> availableHalls = availableCinemaHalls;
  List<Date> availableDates = possibleAvailableDates;

  Set<SeatNumber> selectedSeats = {};

  CinemaHall? choosenHall;
  Date? choosenDate;

  bool isPaymentSheetActive = false;
  bool isProcessingPayment = false;

  togglePaymentSection() {
    isPaymentSheetActive = !isPaymentSheetActive;
    notifyListeners();
  }

  chooseDate(int index) {
    for (int i = 0; i < availableDates.length; i++) {
      if (i == index) {
        availableDates[i].isActive = true;
        choosenDate = availableDates[i];
      } else {
        availableDates[i].isActive = false;
      }
    }
    notifyListeners();
  }

  selectHall(int index) {
    for (int i = 0; i < availableHalls.length; i++) {
      if (i == index) {
        availableHalls[i].isSelected = true;
        choosenHall = availableHalls[i];
      } else {
        availableHalls[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  bool isAbleToProceed() {
    if (choosenDate != null && choosenHall != null) {
      return true;
    }
    return false;
  }

  List<List<SeatState>> seatArrangement = List.generate(
    14,
    (row) => List.generate(
      25,
      (col) {
        if (col == 5 || col == 21) {
          return SeatState.empty;
        }
        if (row < 4 && (col == 0 || col == 25)) {
          return SeatState.empty;
        }
        if (row == 4 && (col == 0 || col == 25)) {
          return SeatState.empty;
        }
        if (row == 0 && (col < 3 || col > 22)) {
          return SeatState.empty;
        }

        List<SeatState> statesOtherThanEmpty = [
          SeatState.disabled,
          SeatState.sold,
          SeatState.unselected,
        ];
        return statesOtherThanEmpty[Random().nextInt(3)];
      },
    ),
  );

  List<List<SeatState>> selectedHallSeatArrangement = List.generate(
    10,
    (row) => List.generate(
      26,
      (col) {
        if (col == 5 || col == 20) {
          return SeatState.empty;
        }
        if (row < 4 && (col == 0 || col == 25)) {
          return SeatState.empty;
        }
        if (row == 0 && (col < 3 || col > 22)) {
          return SeatState.empty;
        }
        List<SeatState> statesOtherThanEmpty = [
          SeatState.disabled,
          SeatState.sold,
          SeatState.unselected,
        ];
        return statesOtherThanEmpty[Random().nextInt(3)];
      },
    ),
  );
  onSeatStateChanged(row, col, seatState) {
    if (seatState == SeatState.selected) {
      selectedSeats.add(SeatNumber(rowI: row, colI: col));
    } else {
      selectedSeats.remove(SeatNumber(rowI: row, colI: col));
    }
    notifyListeners();
  }

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(date);
  }

  proceedToPayment() async {
    await dummyPaymentDelay();
  }

  dummyPaymentDelay() async {
    isProcessingPayment = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isProcessingPayment = false;
    notifyListeners();
    GoRouter.of(getContext!).push(AppRoutes.dashboard);
  }
}
