import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/member.dart';
import '../core/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemberDetailScreen extends StatelessWidget {
  final Member member;

  const MemberDetailScreen({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'avatar_${member.id}',
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(member.profileImageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ),
              title: Hero(
                tag: 'name_${member.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    member.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusCard(context),
                  const SizedBox(height: 24),
                  Text('Physical Stats', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatBox(context, 'Weight', '${member.weight.toStringAsFixed(1)} kg', FontAwesomeIcons.weightScale, Colors.blue),
                      const SizedBox(width: 16),
                      _buildStatBox(context, 'Height', '${member.height.toStringAsFixed(1)} cm', FontAwesomeIcons.rulerVertical, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  _buildQuickActions(context),
                  const SizedBox(height: 32),
                  Text('Attendance History', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: member.attendanceHistory.length,
                    itemBuilder: (context, index) {
                      final date = member.attendanceHistory[index];
                      return ListTile(
                        leading: const Icon(Icons.check_circle_outline, color: AppTheme.primaryColor),
                        title: Text(DateFormat('EEEE, MMM d, yyyy').format(date)),
                        subtitle: Text(DateFormat('h:mm a').format(date)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.surfaceColor, AppTheme.surfaceColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Plan', style: TextStyle(color: AppTheme.textSecondaryColor)),
              Text(
                member.plan.displayName,
                style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const Divider(height: 30, color: Colors.white24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Status', style: TextStyle(color: AppTheme.textSecondaryColor)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: member.isActive ? AppTheme.primaryColor.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  member.isActive ? 'Active' : 'Expired',
                  style: TextStyle(
                    color: member.isActive ? AppTheme.primaryColor : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Expires on', style: TextStyle(color: AppTheme.textSecondaryColor)),
              Text(
                DateFormat('MMM d, yyyy').format(member.planExpiryDate),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
           const SizedBox(height: 12),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Objective', style: TextStyle(color: AppTheme.textSecondaryColor)),
              Text(
                member.objective,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(BuildContext context, String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20)),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(context, FontAwesomeIcons.phone, 'Call', Colors.green),
        _buildActionButton(context, FontAwesomeIcons.solidEnvelope, 'Email', Colors.blue),
        _buildActionButton(context, FontAwesomeIcons.whatsapp, 'Message', Colors.teal),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }
}
