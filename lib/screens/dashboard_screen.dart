import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/gym_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/revenue_chart.dart';
import '../core/theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=admin'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<GymProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: provider.loadMockData,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.1,
                    children: [
                      StatCard(
                        title: 'Total Members',
                        value: provider.totalMembers.toString(),
                        icon: FontAwesomeIcons.users,
                        color: Colors.blueAccent,
                      ),
                      StatCard(
                        title: 'Active Plans',
                        value: provider.activeMembers.toString(),
                        icon: FontAwesomeIcons.bolt,
                        color: AppTheme.primaryColor,
                      ),
                      StatCard(
                        title: 'Expected Revenue',
                        value: '\$${provider.estimatedMonthlyRevenue.toStringAsFixed(0)}',
                        icon: FontAwesomeIcons.dollarSign,
                        color: Colors.amber,
                        subtitle: 'Monthly',
                      ),
                      StatCard(
                        title: 'Expiring Soon',
                        value: provider.expiringSoon.toString(),
                        icon: FontAwesomeIcons.clockRotateLeft,
                        color: AppTheme.errorColor,
                        subtitle: '< 7 Days',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const RevenueChart(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Check-ins',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All', style: TextStyle(color: AppTheme.primaryColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Mock recent check-ins
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (provider.members.isEmpty) return const SizedBox.shrink();
                      final member = provider.members[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(member.profileImageUrl),
                        ),
                        title: Text(member.name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          'Checked in 10 mins ago',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        trailing: const Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 20),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
