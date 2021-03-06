import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/game_state.dart';

typedef PositionCallback = Future Function(Offset pos, double rad);

class BirdNode extends Node {

  BirdNode({ this.size, this.color, this.pos, this.jumpSpeed, this.posEvent }) {
    initialPos = pos;
  }

  double size;
  Color color;
  Offset initialPos;
  Offset pos;
  double jumpSpeed;
  Offset vel = Offset(0.0, 0.0);
  PositionCallback posEvent;

  void jump() {
    vel = Offset(vel.dx, jumpSpeed);
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(gs.balancedOffset(pos), gs.sw(size), Paint()..color = color);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gs.status != GameStatus.PLAYING) {
      pos = initialPos;
      vel = Offset(0.0, 0.0);
      return;
    }

    vel = vel.translate(0.0, gs.gravity);
    final newPos = pos.translate(vel.dx, vel.dy);
    if (pos.dx != newPos.dx || pos.dy != newPos.dy) {
      posEvent(newPos, size);
      pos = newPos;
    }
  }

}
