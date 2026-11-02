class Member {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final DateTime joinDate;
  final Plan plan;
  final DateTime planExpiryDate;
  final List<DateTime> attendanceHistory;
  final double weight;
  final double height;
  final String objective;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.joinDate,
    required this.plan,
    required this.planExpiryDate,
    required this.attendanceHistory,
    required this.weight,
    required this.height,
    required this.objective,
  });

  bool get isActive => DateTime.now().isBefore(planExpiryDate);
  int get attendancesThisMonth {
    final now = DateTime.now();
    return attendanceHistory.where((date) => date.month == now.month && date.year == now.year).length;
  }
}

enum Plan {
  basic,
  premium,
  vip;

  String get displayName {
    switch (this) {
      case Plan.basic:
        return 'Basic Plan';
      case Plan.premium:
        return 'Premium Plan';
      case Plan.vip:
        return 'VIP Plan';
    }
  }

  double get price {
    switch (this) {
      case Plan.basic:
        return 29.99;
      case Plan.premium:
        return 59.99;
      case Plan.vip:
        return 99.99;
    }
  }
}
