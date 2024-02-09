import '../Components/Charts.dart';
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
//   void connectButtonClicked(BuildContext context) {
//     // Add your backend call logic here
//     // For example, you can use a package like http to make an HTTP request
//     // You can also use other methods like Dio, Chopper, etc.

//     // Placeholder example using print statement
//     print("Connect button clicked! Make backend call here.");

// // Call this function where you want to trigger the delete action, for example, in a button onPressed callback
//     // deleteItems(context,
//     //     'device_1'); // Replace 'your_container_name' with the actual container name

//     // You can also navigate to another screen or show a dialog based on the backend response
//   }

  Future<void> connectButtonClicked(BuildContext context) async {
    final backendUrl =
        'http://10.10.12.178/api/hello_world'; // Replace with your actual backend URL

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: '{"message": "Hello, World!"}',
      );

      if (response.statusCode == 200) {
        // Successful response from the backend
        print("Backend response: ${response.body}");

        // Add your logic here based on the backend response
        // For example, show a success message or navigate to another screen
      } else {
        // Handle unsuccessful response from the backend
        print("Backend error: ${response.statusCode}");

        // You can show an error message or handle it accordingly
      }
    } catch (error) {
      // Handle any network or other errors
      print("Error: $error");
    }
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
                    'Power Consumption by $title',
                    style: const TextStyle(
                      fontSize: 20,

                    ),
                  ),
                  const SizedBox(height: 8),
                  LineChartSample(),
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
