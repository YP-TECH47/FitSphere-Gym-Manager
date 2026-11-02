import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/member.dart';
import '../providers/gym_provider.dart';
import '../core/theme.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  
  Plan _selectedPlan = Plan.basic;
  String _selectedObjective = 'Build Muscle';
  final List<String> _objectives = ['Build Muscle', 'Lose Weight', 'Stay Fit', 'Powerlifting', 'Cardio'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Member')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionTitle('Personal Details'),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => !v!.contains('@') ? 'Invalid email' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)),
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            
            _buildSectionTitle('Physical Stats'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Weight (kg)', prefixIcon: Icon(Icons.fitness_center)),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)', prefixIcon: Icon(Icons.height)),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            
            _buildSectionTitle('Membership Plan'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Plan>(
                  value: _selectedPlan,
                  dropdownColor: AppTheme.surfaceColor,
                  isExpanded: true,
                  items: Plan.values.map((plan) {
                    return DropdownMenuItem(
                      value: plan,
                      child: Text(plan.displayName),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedPlan = val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
             Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedObjective,
                  dropdownColor: AppTheme.surfaceColor,
                  isExpanded: true,
                  items: _objectives.map((obj) {
                    return DropdownMenuItem(
                      value: obj,
                      child: Text(obj),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedObjective = val);
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveMember,
              child: const Text('REGISTER MEMBER'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  void _saveMember() {
    if (_formKey.currentState!.validate()) {
      final newMember = Member(
        id: 'M-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        profileImageUrl: 'https://i.pravatar.cc/150?u=${_emailController.text}',
        joinDate: DateTime.now(),
        plan: _selectedPlan,
        planExpiryDate: DateTime.now().add(const Duration(days: 30)), // 1 month default
        attendanceHistory: [],
        weight: double.tryParse(_weightController.text) ?? 70.0,
        height: double.tryParse(_heightController.text) ?? 170.0,
        objective: _selectedObjective,
      );

      Provider.of<GymProvider>(context, listen: false).addMember(newMember);
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newMember.name} successfully registered!'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}
