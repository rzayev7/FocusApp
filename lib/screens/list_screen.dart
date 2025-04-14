import 'package:flutter/material.dart';
import 'package:focus_app_project/models/item_model.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ItemModel> items = [
    ItemModel(title: 'Focus Timer', description: 'A timer to help you focus.'),
    ItemModel(title: 'Daily Tasks', description: 'Manage daily tasks easily.'),
    ItemModel(title: 'Reminders', description: 'Never miss an important event.'),
  ];

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Features List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].description),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeItem(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
