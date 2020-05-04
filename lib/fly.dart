import 'dart:ui';
import 'package:flutter/material.dart';

class Fly {
  Rect flyRect;
  double tileSize;
  Paint flyPaint = Paint();
  bool isDead = false;

  Fly({this.tileSize, double x, double y}) {
    flyRect = Rect.fromLTWH(x, y, tileSize, tileSize);
    flyPaint.color = Colors.green;
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, 12 * tileSize * t);
    }
  }

  void render(Canvas canvas) {
    //print("fly render gets called");
    canvas.drawRect(flyRect, flyPaint);
  }

  void onTapDown() {
    flyPaint.color = Colors.red;
    isDead = true;
  }
}
