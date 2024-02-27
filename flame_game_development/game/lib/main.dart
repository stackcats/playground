import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/components/player_image_sprite_component.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  void onLoad() {
    debugMode = true;d
    add(PlayerImageSpriteComponent());
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    print(event);
    return KeyEventResult.handled;
  }
}

void main() async {
  runApp(GameWidget(game: MyGame()));
}
