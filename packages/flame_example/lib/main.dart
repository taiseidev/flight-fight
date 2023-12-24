import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_example/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlameAudio.bgm.initialize();
  FlameAudio.bgm.play('sound.mp3');

  runApp(
    GameWidget(
      game: SpaceShooterGame(),
    ),
  );
}
