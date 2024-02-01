class CinemaHall {
  final String name;
  final String timing;
  final double cost;
  final int bonus;
  bool? isSelected;

  CinemaHall({
    required this.name,
    required this.timing,
    required this.cost,
    required this.bonus,
    this.isSelected,
  });
}

List<CinemaHall> availableCinemaHalls = [
  CinemaHall(
    name: 'Cinetech + Hall 1',
    timing: '12:30',
    cost: 50.0,
    bonus: 2500,
    isSelected: false,
  ),
  CinemaHall(
    name: 'Cinetech + Hall 2',
    timing: '2:00',
    cost: 25.5,
    bonus: 1500,
    isSelected: false,
  ),
];
