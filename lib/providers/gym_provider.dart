import 'package:flutter/material.dart';
import '../models/member.dart';
import '../core/mock_data.dart';

class GymProvider with ChangeNotifier {
  List<Member> _members = [];
  bool _isLoading = true;

  List<Member> get members => _members;
  bool get isLoading => _isLoading;

  int get totalMembers => _members.length;
  int get activeMembers => _members.where((m) => m.isActive).length;
  int get expiringSoon => _members.where((m) => m.isActive && m.planExpiryDate.difference(DateTime.now()).inDays <= 7).length;
  
  double get estimatedMonthlyRevenue {
    return _members.where((m) => m.isActive).fold(0.0, (sum, m) => sum + m.plan.price);
  }

  // Load initial mock data
  Future<void> loadMockData() async {
    _isLoading = true;
    notifyListeners();
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    _members = MockData.generateMembers(20); // Generate 20 members
    
    _isLoading = false;
    notifyListeners();
  }

  void addMember(Member member) {
    _members.insert(0, member); // Add to top
    notifyListeners();
  }

  void updateMember(Member updatedMember) {
    final index = _members.indexWhere((m) => m.id == updatedMember.id);
    if (index >= 0) {
      _members[index] = updatedMember;
      notifyListeners();
    }
  }

  void deleteMember(String id) {
    _members.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  List<Member> searchMembers(String query) {
    if (query.isEmpty) return _members;
    final lowerQuery = query.toLowerCase();
    return _members.where((m) => m.name.toLowerCase().contains(lowerQuery) || m.phone.contains(lowerQuery)).toList();
  }
}
