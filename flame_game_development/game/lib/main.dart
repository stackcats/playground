import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/components/player_image_sprite_component.dart';
import 'components/circle_position_component.dart';
import 'components/background_image_component.dart';
import 'components/meteor_component.dart';
import 'components/tile_map_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  double elapsedTime = 0;
  // final world = World();
  // late final CameraComponent camera;
  @override
  void onLoad() {
    debugMode = true;
    add(world);
    final background = TileMapComponent();
    add(background);
    // add(PlayerComponent());
    add(ScreenHitbox());

    background.loaded.then((value) {
      final player = PlayerComponent(mapSize: background.size);
      add(player);
    });
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

  @override
  void update(double dt) {
    if (elapsedTime >= 1) {
      Vector2 cp = camera.viewfinder.position;
      cp.y -= camera.viewport.size.y;
      // world.add(MeteorComponent(cameraPosition: cp));
      elapsedTime = 0;
    }
    elapsedTime += dt;
    super.update(dt);
  }
}

void main() async {
  runApp(GameWidget(game: MyGame()));
}
