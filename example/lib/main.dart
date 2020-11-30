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
  Gradient g1 = LinearGradient(
    colors: [
      Color(0xFF7F00FF),
      Color(0xFFE100FF),
    ],
  );
  Gradient g2 = LinearGradient(colors: [
    Color(0xfff12711),
    Color(0xfff5af19),
  ]);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 80);
    Widget space2 = SizedBox(height: 20);
    Widget space2_w = SizedBox(width: 20);

    return Scaffold(
      floatingActionButton: Column(
        children: [
          Spacer(),
          a.GradientFloatingActionButton.extended(
            onPressed: () {},
            label: Text("This is a FAB"),
            icon: Icon(Icons.add),
            shape: StadiumBorder(),
            gradient: g1,
          ),
          space2,
          a.GradientFloatingActionButton.extended(
            onPressed: () {},
            label: Text("This is a FAB"),
            icon: Icon(Icons.add),
            shape: StadiumBorder(),
            gradient: g2,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            space,
            Row(
              children: [
                Spacer(),
                Flexible(
                  child: Column(
                    children: [
                      a.GradientLinearProgressIndicator(
                        valueGradient: g1,
                        backgroundColor: Colors.grey[200],
                      ),
                      space2,
                      a.GradientLinearProgressIndicator(
                        valueGradient: g2,
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Flexible(
                  child: Row(
                    children: [
                      a.GradientCircularProgressIndicator(
                        valueGradient: g1,
                        backgroundColor: Colors.grey[200],
                      ),
                      space2_w,
                      a.GradientCircularProgressIndicator(
                        valueGradient: g2,
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            space,
            Row(
              children: [
                Spacer(),
                Flexible(
                  child: Column(
                    children: [
                      a.GradientLinearProgressIndicator(
                        valueGradient: g1,
                        value: 0.8,
                        backgroundColor: Colors.grey[200],
                      ),
                      space2,
                      a.GradientLinearProgressIndicator(
                        valueGradient: g2,
                        value: 0.8,
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Flexible(
                  child: Row(
                    children: [
                      a.GradientCircularProgressIndicator(
                        valueGradient: g1,
                        value: 0.8,
                        backgroundColor: Colors.grey[200],
                      ),
                      space2_w,
                      a.GradientCircularProgressIndicator(
                        valueGradient: g2,
                        value: 0.8,
                        backgroundColor: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    a.GradientRaisedButton(
                      onPressed: () {},
                      gradient: g1,
                      textColor: Colors.white,
                      child: Text("This is a button"),
                    ),
                    space2,
                    a.GradientRaisedButton(
                      onPressed: () {},
                      gradient: g2,
                      textColor: Colors.white,
                      child: Text("This is a button"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    a.GradientFloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.wysiwyg),
                      shape: StadiumBorder(),
                      gradient: g1,
                    ),
                    space2_w,
                    a.GradientFloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.wysiwyg),
                      shape: StadiumBorder(),
                      gradient: g2,
                    ),
                  ],
                ),
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                a.GradientSelectableText(
                  "THIS IS A SELECTABLE",
                  gradient: g1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                a.GradientSelectableText(
                  "GRADIENT TEXT",
                  gradient: g2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      a.GradientIcon(
                        Icons.add_box,
                        gradient: g1,
                        size: 70,
                      ),
                      a.GradientIcon(
                        Icons.add_box,
                        gradient: g2,
                        size: 70,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      a.GradientIconButton(
                        icon: Icon(Icons.wrong_location),
                        gradient: g1,
                        iconSize: 70,
                        onPressed: () => {},
                      ),
                      a.GradientIconButton(
                        icon: Icon(Icons.wrong_location),
                        gradient: g2,
                        iconSize: 70,
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      a.GradientIcon(
                        Icons.cloud,
                        gradient: g1,
                        size: 70,
                      ),
                      a.GradientIcon(
                        Icons.cloud,
                        gradient: g2,
                        size: 70,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            space,
          ],
        ),
      ),
    );
  }
}
