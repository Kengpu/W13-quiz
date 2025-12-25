import 'package:flutter/material.dart';

import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryTabState();
}

class _GroceryTabState extends State<GroceryList> {
  void onCreate() async {
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );

    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget groceryContent =
        const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      groceryContent = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) {
          return GroceryTile(grocery: dummyGroceryItems[index]);
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Groceries'),
          actions: [
            IconButton(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_grocery_store)),
              Tab(icon: Icon(Icons.search)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            groceryContent,
            const Center(
              child: Text(
                'Search tab coming soon',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 15,
        height: 15,
        color: grocery.category.color,
      ),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
