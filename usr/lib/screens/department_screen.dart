import 'package:flutter/material.dart';
import 'package:couldai_user_app/services/mock_data_service.dart';

class DepartmentScreen extends StatefulWidget {
  final String departmentName;

  const DepartmentScreen({super.key, required this.departmentName});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final _nameController = TextEditingController();

  void _addPerson() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Person'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                setState(() {
                  MockDataService().addPerson(
                    widget.departmentName,
                    _nameController.text,
                  );
                });
                _nameController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removePerson(String name) {
    setState(() {
      MockDataService().removePerson(widget.departmentName, name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final people = MockDataService().getPeople(widget.departmentName);
    final isIT = widget.departmentName == 'IT';

    return Scaffold(
      appBar: AppBar(title: Text('${widget.departmentName} Department')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              isIT
                  ? 'Private Information & People Management'
                  : 'People Information & Management',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(person),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removePerson(person),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPerson,
        child: const Icon(Icons.add),
      ),
    );
  }
}
