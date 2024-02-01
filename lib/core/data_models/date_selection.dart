class Date {
  String date;
  bool? isActive;

  Date({
    required this.date,
    this.isActive,
  });
}

List<Date> possibleAvailableDates = [
  Date(date: '5 Mar', isActive: false),
  Date(date: '6 Mar', isActive: false),
  Date(date: '7 Mar', isActive: false),
  Date(date: '8 Mar', isActive: false),
  Date(date: '9 Mar', isActive: false),
  Date(date: '10 Mar', isActive: false),
  Date(date: '11 Mar', isActive: false),
];
