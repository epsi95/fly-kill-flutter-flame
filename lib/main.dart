import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'fly-game.dart';

void main() async {
  FlyGame flyGame = FlyGame();
  runApp(flyGame.widget);

  Util gameUtil = Util();
  await gameUtil.setOrientation(DeviceOrientation.portraitUp);
  await gameUtil.fullScreen();
}
