import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

typedef PositionCallback = Future Function(Offset pos);

class BirdNode extends Node {

  BirdNode({ this.size, this.color, this.pos, this.posEvent }) {
    initialPos = pos;
  }

  double size;
  Color color;
  Offset initialPos;
  Offset pos;
  Offset vel = Offset(0.0, 0.0);
  PositionCallback posEvent;

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(pos, size, Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (GameState().status != GameStatus.PLAYING) {
      pos = initialPos;
      vel = Offset(0.0, 0.0);
      return;
    }

    vel = vel.translate(0.0, GameState().regularize(GameState().gravity, Axis.vertical));
    final newPos = pos.translate(vel.dx, vel.dy);
    if (pos.dx != newPos.dx || pos.dy != newPos.dy) {
      posEvent(newPos);
      pos = newPos;
    }
  }

}
