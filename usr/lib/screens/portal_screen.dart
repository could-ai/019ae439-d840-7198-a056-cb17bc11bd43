import 'package:flutter/material.dart';
import 'package:couldai_user_app/services/mock_data_service.dart';
import 'package:couldai_user_app/screens/department_screen.dart';
import 'package:couldai_user_app/screens/dna_center_screen.dart';

class PortalScreen extends StatelessWidget {
  const PortalScreen({super.key});

  void _enterDepartment(BuildContext context, String name, String requiredCode) {
    final codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter $name Code'),
        content: TextField(
          controller: codeController,
          decoration: const InputDecoration(hintText: 'Portal Code'),
          keyboardType: TextInputType.number,
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (codeController.text == requiredCode) {
                Navigator.pop(context); // Close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DepartmentScreen(departmentName: name),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid Code')),
                );
              }
            },
            child: const Text('Enter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Academy Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildPortalCard(
            context,
            'HR Department',
            Icons.people,
            Colors.blue,
            () => _enterDepartment(context, 'HR', MockDataService.hrCode),
          ),
          _buildPortalCard(
            context,
            'IT Department',
            Icons.computer,
            Colors.green,
            () => _enterDepartment(context, 'IT', MockDataService.itCode),
          ),
          _buildPortalCard(
            context,
            'DNA Center',
            Icons.security,
            Colors.red,
            () {
              // DNA Center requires no code
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DnaCenterScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPortalCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
