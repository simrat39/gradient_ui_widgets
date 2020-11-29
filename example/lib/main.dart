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
      theme: ThemeData(
        accentColor: Color(0xff7f00ff),
        backgroundColor: Colors.grey[200],
      ),
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
      Color(0xFF7F00FF),
      Color(0xFFE100FF),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: a.GradientFloatingActionButton.extended(
        onPressed: () {},
        label: Text("This is a FAB"),
        icon: Icon(Icons.add),
        shape: StadiumBorder(),
        gradient: g,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Spacer(),
              Flexible(
                child: a.GradientLinearProgressIndicator(
                  valueGradient: g,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Spacer(),
              Flexible(
                child: a.GradientCircularProgressIndicator(
                  valueGradient: g,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Spacer(),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Flexible(
                child: a.GradientLinearProgressIndicator(
                  valueGradient: g,
                  value: 0.8,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Spacer(),
              Flexible(
                child: a.GradientCircularProgressIndicator(
                  valueGradient: g,
                  value: 0.8,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Spacer(),
            ],
          ),
          a.GradientRaisedButton(
            onPressed: () {},
            gradient: g,
            textColor: Colors.white,
            child: Text("This is a button"),
          ),
          a.GradientFloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.wysiwyg),
            shape: StadiumBorder(),
            gradient: g,
          ),
          a.GradientText(
            "THIS IS A \nGRADIENT TEXT",
            gradient: g,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: a.GradientIcon(
                  Icons.add_box,
                  gradient: g,
                  size: 70,
                ),
              ),
              Flexible(
                child: a.GradientIcon(
                  Icons.wrong_location,
                  gradient: g,
                  size: 70,
                ),
              ),
              Flexible(
                child: a.GradientIcon(
                  Icons.cloud,
                  gradient: g,
                  size: 70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
