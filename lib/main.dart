import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade900,
        child: CustomPaint(
          painter: MyPaint(),
          size: Size(200, 200),
        ),
      ),
    );
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var _centerX = size.width / 2;
    var _centerY = size.height / 2;
    var _center = Offset(_centerX, _centerY);
    var _radius = size.width / 2;

    var borderExternalClock = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    var innerCircle = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    var lineSeconds = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
        Rect.fromCenter(
          center: _center,
          width: size.width,
          height: size.height,
        ),
        0,
        pi * 2,
        false,
        borderExternalClock);
    canvas.drawCircle(_center, size.width / 2, innerCircle);

    canvas.drawLine(_centerX, p2, lineSeconds);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
