import 'package:flutter/material.dart';
import 'package:couldai_user_app/services/mock_data_service.dart';

class DnaCenterScreen extends StatefulWidget {
  const DnaCenterScreen({super.key});

  @override
  State<DnaCenterScreen> createState() => _DnaCenterScreenState();
}

class _DnaCenterScreenState extends State<DnaCenterScreen> {
  final _emailController = TextEditingController();

  void _unlockAccount() {
    final email = _emailController.text.trim();
    if (email.isNotEmpty) {
      if (MockDataService().isUserBlocked(email)) {
        MockDataService().unlockAccount(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account for $email has been unlocked.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User is not blocked or does not exist.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DNA Center'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Security & Access Control',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Unlike others, you can log in to DNA Center without entering a code. This allows employees to reset blocked passwords.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'Unlock Blocked Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'User Email Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_open),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _unlockAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Unlock Account'),
            ),
          ],
        ),
      ),
    );
  }
}
