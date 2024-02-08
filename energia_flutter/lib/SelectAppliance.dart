import 'package:flutter/material.dart';
import './Components/BottomNavBar.dart';
import 'ApplianceDetail.dart';
import './Components/SearchBar.dart';

class SelectAppliance extends StatelessWidget {
  const SelectAppliance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 240,
        title: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 25.0, 0,20),
                child: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const Text(
                'Appliances',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SearchBarApp(),
            ],
          ),
        ),
        ),

      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: <Widget>[
          buildCard(context, 'Air Conditioner',
              'assets/Air Conditioner.jpg'),
          buildCard(
              context, 'Iron', 'assets/Iron.jpg'),
          buildCard(context, 'Kitchen Stove',
              'assets/Kitchen Stove.jpeg'),
          buildCard(context, 'Lighting',
              'assets/Lighting.jpeg'),
          buildCard(context, 'Refrigerator',
              'assets/Refrigerators.jpg'),
          buildCard(context, 'Television',
              'assets/TV.jpg'),
          buildCard(context, 'Vacuum Cleaner',
              'assets/Vacuum Cleaner.jpeg'),
          buildCard(context, 'Washing Machine',
              'assets/Washing Machine.jpeg'),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context,
      String title, String imagePath) {
    return InkWell(
      onTap: () {
        // Navigate to a new page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ApplianceDetail (title, imagePath),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                imagePath,
                height: 128,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}