import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String image;

  const CustomCard({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle card click action here
        print('$name card clicked');
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/$image',
              height: 120.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
