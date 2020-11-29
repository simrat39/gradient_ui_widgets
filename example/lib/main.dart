import 'package:gradient_widgets/gradient_widgets.dart' as a;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Gradient g = LinearGradient(
    colors: [
      Color(0xFF0D47A1),
      Color(0xFF1976D2),
      Color(0xFF42A5F5),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            a.GradientLinearProgressIndicator(
              valueGradient: g,
            ),
            a.GradientRaisedButton(
              onPressed: () {
                print("hi");
              },
              gradient: g,
              textColor: Colors.white,
              child: Text("Gradient Button", style: TextStyle()),
            ),
          ],
        ),
      ),
    );
  }
}
