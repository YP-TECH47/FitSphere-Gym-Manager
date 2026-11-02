import 'package:flutter/material.dart';
import '../models/member.dart';
import '../core/theme.dart';
import 'package:intl/intl.dart';

class MemberListTile extends StatelessWidget {
  final Member member;
  final VoidCallback onTap;

  const MemberListTile({
    Key? key,
    required this.member,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'avatar_${member.id}',
              child: CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.accentColor.withOpacity(0.2),
                backgroundImage: NetworkImage(member.profileImageUrl),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'name_${member.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        member.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member.plan.displayName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: member.isActive 
                        ? AppTheme.primaryColor.withOpacity(0.2)
                        : AppTheme.errorColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    member.isActive ? 'Active' : 'Expired',
                    style: TextStyle(
                      color: member.isActive ? AppTheme.primaryColor : AppTheme.errorColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ID: ${member.id}',
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
