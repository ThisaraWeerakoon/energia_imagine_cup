import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

// void deleteItems(BuildContext context, String containerName) async {
//   final backendUrl =
//       'http://10.10.12.178/api/delete_items/$containerName'; // Replace with your actual backend URL

//   try {
//     final response = await http.delete(Uri.parse(backendUrl));

//     if (response.statusCode == 200) {
//       // Items deleted successfully, you can show a success message or perform other actions
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Success"),
//             content: Text(
//                 "All items in container $containerName deleted successfully."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the dialog
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Deletion failed, show an error dialog or handle accordingly
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Deletion Error"),
//             content: Text("Failed to delete items. Please try again."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the dialog
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } catch (error) {
//     // Handle any network or other errors
//     print("Error: $error");
//   }
// }

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

// Call this function where you want to trigger the delete action, for example, in a button onPressed callback
    // deleteItems(context,
    //     'device_1'); // Replace 'your_container_name' with the actual container name

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
