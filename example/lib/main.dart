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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: a.GradientLinearProgressIndicator(
          valueGradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.purple,
            ],
          ),
        ),
      ),
    );
  }
}
