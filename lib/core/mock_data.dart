import 'dart:math';
import '../models/member.dart';

class MockData {
  static final Random _random = Random();
  
  static const List<String> _firstNames = [
    'Alex', 'Jordan', 'Taylor', 'Casey', 'Morgan', 'Riley', 'Cameron', 'Quinn', 'Jamie', 'Skyler',
    'Devendra', 'Sarah', 'Michael', 'Emma', 'David', 'Sophia', 'James', 'Olivia', 'Daniel', 'Ava'
  ];
  
  static const List<String> _lastNames = [
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez',
    'Kumar', 'Lee', 'Wong', 'Kim', 'Patel', 'Chen', 'Singh', 'Nguyen', 'Ali', 'Gomez'
  ];

  static List<Member> generateMembers(int count) {
    return List.generate(count, (index) {
      final now = DateTime.now();
      final joinDaysAgo = _random.nextInt(365);
      final joinDate = now.subtract(Duration(days: joinDaysAgo));
      
      final planValues = Plan.values;
      final plan = planValues[_random.nextInt(planValues.length)];
      
      // 80% chance of being active
      final isActiveUser = _random.nextDouble() > 0.2;
      final expiryDays = isActiveUser ? _random.nextInt(180) + 1 : -(_random.nextInt(60) + 1);
      final expiryDate = now.add(Duration(days: expiryDays));
      
      // Generate some random attendance dates usually in past 30 days
      final attendanceCount = _random.nextInt(20);
      final List<DateTime> history = List.generate(attendanceCount, (i) {
        return now.subtract(Duration(days: _random.nextInt(30), hours: _random.nextInt(24)));
      });
      
      final firstName = _firstNames[_random.nextInt(_firstNames.length)];
      final lastName = _lastNames[_random.nextInt(_lastNames.length)];
      
      return Member(
        id: 'M-${1000 + index}',
        name: '$firstName $lastName',
        email: '${firstName.toLowerCase()}.${lastName.toLowerCase()}@example.com',
        phone: '+1 (555) ${_random.nextInt(900) + 100}-${_random.nextInt(9000) + 1000}',
        profileImageUrl: 'https://i.pravatar.cc/150?u=gym_${index}',
        joinDate: joinDate,
        plan: plan,
        planExpiryDate: expiryDate,
        attendanceHistory: history..sort((a, b) => b.compareTo(a)),
        weight: 60.0 + _random.nextDouble() * 50.0,
        height: 150.0 + _random.nextDouble() * 45.0,
        objective: ['Build Muscle', 'Lose Weight', 'Stay Fit', 'Powerlifting', 'Cardio'][_random.nextInt(5)],
      );
    });
  }
}
