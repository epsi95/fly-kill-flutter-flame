import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'fly.dart';
import 'dart:math';
import 'package:flame/gestures.dart';

class FlyGame extends Game with TapDetector, HorizontalDragDetector {
  Size screenSize;
  double tileSize;
  List<Fly> flies = [];
  Random random = Random();

  FlyGame() {
    initialize();
  }

  void initialize() async {
    print('initializing');
    resize(await Flame.util.initialDimensions());
    spawnFly();
  }

  void spawnFly() {
    double minx = 0;
    double maxx = screenSize.width - tileSize;

    double miny = 0;
    double maxy = screenSize.height - tileSize;

    double x = random.nextDouble() * (maxx - minx) + minx;
    double y = random.nextDouble() * (maxy - miny) + miny;

    flies.add(Fly(tileSize: tileSize, x: x, y: y));
    //print(flies);
  }

  void onTapDown(TapDownDetails details) {
    bool needToSpawnFly = false;
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(details.globalPosition)) {
        needToSpawnFly = true;
        fly.onTapDown();
      }
    });
    if (needToSpawnFly) {
      spawnFly();
    }
  }

  @override
  void update(double t) {
    //print(flies);
    flies.forEach((Fly fly) {
      fly.update(t);
    });

    flies.removeWhere((Fly fly) {
      if (fly.flyRect.top > screenSize.height) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  void render(Canvas canvas) {
    // rendering background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffcb9b42);
    canvas.drawRect(bgRect, bgPaint);

    // rendering flies
    flies.forEach((Fly fly) {
      fly.render(canvas);
    });
  }

  @override
  void resize(Size size) {
    print('resize gets called');
    screenSize = size;
    tileSize = size.width / 9;
  }
}
