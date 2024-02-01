import 'dart:math';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:tentwenty_assignment/core/data_models/date_selection.dart';
import 'package:tentwenty_assignment/core/data_models/seat_number.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';

class SeatingViewModel extends BaseViewModel {
  List<Date> availableDates = [
    Date(date: '5 Mar', isActive: true),
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

  Set<SeatNumber> selectedSeats = {};

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

  onSeatStateChanged(rowI, colI, seatState) {
    if (seatState == SeatState.selected) {
      selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
    } else {
      selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
    }
    notifyListeners();
  }
}




//  COLUMNS: 24
//  ROWS:    14