import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

class BackgroundNode extends Node {

  BackgroundNode({ this.color = Colors.blueGrey, this.parallax = 0.75 }) {
    points.addAll([
      Offset(1, -1),
      Offset(-1, -1),
      Offset(-1, randomSignedDouble() * 0.5)
    ]);
    generatePoint((2 / pointInterval).ceil());
  }

  Color color;
  double parallax;
  final pointInterval = 0.05;
  final slope = 0.01;
  List<Offset> points = [];

  void generatePoint([ int numPoints = 1 ]) {
    for (var n = 0; n < numPoints; n++) {
      points.add(Offset(points.last.dx + pointInterval, points.last.dy + randomSignedDouble() * slope));
    }
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(
      Path()..addPolygon(points.map((p) => Offset(gs.bx(p.dx), gs.by(p.dy))).toList(), true),
      Paint()
        ..style = PaintingStyle.fill
        ..color = color
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gs.status == GameStatus.PLAYING) {
      for (var p = 2; p < points.length; p++) points[p] = points[p].translate(-gs.speed * parallax, 0);
      points.removeWhere((point) => point.dx < -1 - pointInterval);
      if (points.last.dx < 1) generatePoint();
    }
  }

}
