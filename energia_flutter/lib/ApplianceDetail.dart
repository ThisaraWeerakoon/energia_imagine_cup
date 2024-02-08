import 'package:flutter/material.dart';

class ApplianceDetail extends StatelessWidget {
  final String title;
  final String imagePath;

  ApplianceDetail (this.title, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
                  const SizedBox(height: 8),
                  const Text("Appliance Details"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
