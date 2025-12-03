import 'package:flutter/material.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // Mock Users: email -> password
  final Map<String, String> _users = {
    'admin@step.com': 'password123',
    'user@step.com': '123456',
  };

  // Blocked status: email -> isBlocked
  final Map<String, bool> _blockedUsers = {};

  // Failed attempts: email -> count
  final Map<String, int> _failedAttempts = {};

  // Department Data
  final List<String> _hrPeople = ['John Doe', 'Jane Smith', 'Alice Johnson'];
  final List<String> _itPeople = ['Tech Guru', 'Code Master', 'System Admin'];

  // Codes
  static const String hrCode = '897645';
  static const String itCode = '091243';

  // Auth Methods
  bool isUserBlocked(String email) {
    return _blockedUsers[email] ?? false;
  }

  String? login(String email, String password) {
    if (isUserBlocked(email)) {
      return 'Account is blocked. Please contact DNA Center.';
    }

    if (!_users.containsKey(email)) {
      return 'User not found.';
    }

    if (_users[email] == password) {
      // Success
      _failedAttempts[email] = 0;
      return null; // No error
    } else {
      // Failure
      int attempts = (_failedAttempts[email] ?? 0) + 1;
      _failedAttempts[email] = attempts;
      if (attempts >= 3) {
        _blockedUsers[email] = true;
        return 'Account blocked due to 3 failed attempts.';
      }
      return 'Invalid password. Attempt $attempts/3';
    }
  }

  void register(String email, String password) {
    _users[email] = password;
    _failedAttempts[email] = 0;
    _blockedUsers[email] = false;
  }

  void unlockAccount(String email) {
    if (_users.containsKey(email)) {
      _blockedUsers[email] = false;
      _failedAttempts[email] = 0;
    }
  }

  // Data Methods
  List<String> getPeople(String department) {
    if (department == 'HR') return _hrPeople;
    if (department == 'IT') return _itPeople;
    return [];
  }

  void addPerson(String department, String name) {
    if (department == 'HR') _hrPeople.add(name);
    if (department == 'IT') _itPeople.add(name);
  }

  void removePerson(String department, String name) {
    if (department == 'HR') _hrPeople.remove(name);
    if (department == 'IT') _itPeople.remove(name);
  }
}
