import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gym_class.dart';
import '../core/theme.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate some mock classes
    final mockClasses = _generateMockClasses();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule & Classes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockClasses.length,
        itemBuilder: (context, index) {
          final gymClass = mockClasses[index];
          return _buildClassCard(context, gymClass);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        tooltip: 'Add Class',
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, GymClass gymClass) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(gymClass.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gymClass.type,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${gymClass.enrolled}/${gymClass.capacity}',
                        style: TextStyle(
                          color: gymClass.isFull ? AppTheme.errorColor : AppTheme.textSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    gymClass.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: AppTheme.textSecondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        gymClass.instructor,
                        style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: AppTheme.textSecondaryColor),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('h:mm a').format(gymClass.startTime),
                            style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 13),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: gymClass.isFull 
                              ? AppTheme.errorColor.withOpacity(0.2)
                              : AppTheme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          gymClass.isFull ? 'Full' : 'Join',
                          style: TextStyle(
                            color: gymClass.isFull ? AppTheme.errorColor : AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<GymClass> _generateMockClasses() {
    final now = DateTime.now();
    return [
      GymClass(
        id: '1',
        title: 'Morning Yoga',
        instructor: 'Sarah Jenkins',
        startTime: DateTime(now.year, now.month, now.day, 7, 0),
        duration: const Duration(minutes: 60),
        capacity: 20,
        enrolled: 18,
        imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?fit=crop&w=500&q=80',
        type: 'Mind & Body',
      ),
      GymClass(
        id: '2',
        title: 'HIIT Cardio Blast',
        instructor: 'Marcus Strong',
        startTime: DateTime(now.year, now.month, now.day, 9, 30),
        duration: const Duration(minutes: 45),
        capacity: 15,
        enrolled: 15,
        imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?fit=crop&w=500&q=80',
        type: 'High Intensity',
      ),
      GymClass(
        id: '3',
        title: 'Powerlifting 101',
        instructor: 'David Cross',
        startTime: DateTime(now.year, now.month, now.day, 17, 0),
        duration: const Duration(minutes: 90),
        capacity: 10,
        enrolled: 4,
        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?fit=crop&w=500&q=80',
        type: 'Strength',
      ),
      GymClass(
        id: '4',
        title: 'Spinning Enduro',
        instructor: 'Emily Chen',
        startTime: DateTime(now.year, now.month, now.day, 18, 30),
        duration: const Duration(minutes: 60),
        capacity: 25,
        enrolled: 20,
        imageUrl: 'https://images.unsplash.com/photo-1534438097544-e0bdf6065586?fit=crop&w=500&q=80',
        type: 'Cardio',
      ),
    ];
  }
}
