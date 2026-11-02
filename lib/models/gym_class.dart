class GymClass {
  final String id;
  final String title;
  final String instructor;
  final DateTime startTime;
  final Duration duration;
  final int capacity;
  final int enrolled;
  final String imageUrl;
  final String type;

  GymClass({
    required this.id,
    required this.title,
    required this.instructor,
    required this.startTime,
    required this.duration,
    required this.capacity,
    required this.enrolled,
    required this.imageUrl,
    required this.type,
  });

  bool get isFull => enrolled >= capacity;
}
