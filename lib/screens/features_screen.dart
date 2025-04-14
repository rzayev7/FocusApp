import 'package:flutter/material.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
        elevation: 0,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/tr/f/f6/Manchester_City.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Feature Screen Placeholder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/list');
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}