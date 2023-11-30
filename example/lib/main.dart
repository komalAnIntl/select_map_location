import 'package:flutter/material.dart';
import 'package:select_map_location/select_map_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String _address = '';

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  showModal(context);
                  setState(() {});
                },
                child: const Text('Select Location')),
            Text(_address)
          ],
        ),
      ),
    );
  }

  showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CustomOpenStreetMapSearchAndPick(
              center: const CustomLatLong(
                  latitude: 19.218330, longitude: 72.978088),
              buttonColor: Colors.deepPurple,
              buttonText: 'Set Selected Location',
              onPicked: (CustomPickedData pickedData) {
                _address = pickedData.addressName;

                Navigator.pop(context);
              },
            ),
          );
        });
  }
}
