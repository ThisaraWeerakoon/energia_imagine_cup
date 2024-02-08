import 'package:flutter/material.dart';

class ApplianceDetail extends StatelessWidget {
  final String title;
  final String imagePath;

  ApplianceDetail(this.title, this.imagePath);

  // Function to handle the Connect button click
  void connectButtonClicked(BuildContext context) {
    // Add your backend call logic here
    // For example, you can use a package like http to make an HTTP request
    // You can also use other methods like Dio, Chopper, etc.

    // Placeholder example using print statement
    print("Connect button clicked! Make backend call here.");

    // You can also navigate to another screen or show a dialog based on the backend response
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Appliance Details"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => connectButtonClicked(context),
        label: Text("Connect", style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.bluetooth, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
