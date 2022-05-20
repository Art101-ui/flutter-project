import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Initially display FirstPage
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routing App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'First Page',
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              child: const Text('Go to second'),
              onPressed: () {
                // Pushing a route directly, WITHOUT using a named route
                Navigator.of(context).push(
                  // With MaterialPageRoute, you can pass data between pages,
                  // but if you have a more complex app, you will quickly get lost.
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondPage(data: 'Hello there from the first page!'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  // This is a String for the sake of an example.
  // You can use any type you want.
  final String data;

  SecondPage({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routing App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Second Page',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              data,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
