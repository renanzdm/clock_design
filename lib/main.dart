import 'dart:async';
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
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade900,
        child: Transform.rotate(
          angle: -(0.0174533 * 90),
          child: CustomPaint(
            painter: MyPaint(),
            size: Size(200, 200),
          ),
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
    var secondsLineWidht = _radius / 1.25;
    var minuteLineWidht = _radius / 1.5;
    var hourLineWidht = _radius / 2;
    final now = DateTime.now();

    final _hourDegree = (360 / 12) * now.hour;
    final _minutesDegree = (360 / 60) * now.minute;
    final _secondsDegree = (360 / 60) * now.second;
    final _secondsLineRadian = degreeToRadian(_secondsDegree);
    final _minuteLineRadian = degreeToRadian(_minutesDegree);
    final _hoursLineRadian = degreeToRadian(_hourDegree);

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
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    var lineMinutes = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    var lineHours = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    var outerCircleCenter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    var innerCircleCenter = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

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
    canvas.drawCircle(_center, _radius, innerCircle);

    canvas.drawLine(
        Offset(_centerX + cos(_hoursLineRadian) * hourLineWidht,
            _centerY + sin(_hoursLineRadian) * hourLineWidht),
        _center,
        lineHours);
    canvas.drawLine(
        Offset(_centerX + cos(_minuteLineRadian) * minuteLineWidht,
            _centerY + sin(_minuteLineRadian) * minuteLineWidht),
        _center,
        lineMinutes);
    canvas.drawCircle(_center, 6, outerCircleCenter);
    canvas.drawCircle(_center, 3, innerCircleCenter);
    canvas.drawLine(
        Offset(_centerX + cos(_secondsLineRadian) * secondsLineWidht,
            _centerY + sin(_secondsLineRadian) * secondsLineWidht),
        _center,
        lineSeconds);
  }

  double degreeToRadian(double degree) => degree * 0.0174533;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
