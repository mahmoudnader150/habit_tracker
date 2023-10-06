class Habit{
  String name;
  String description;
  String userEmail;
  bool done ;
  Habit({
    required this.name,
    required this.description,
    required this.userEmail,
    this.done = false,
});
}