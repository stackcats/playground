import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game/components/ground.dart';
import 'package:tiled/tiled.dart';

class TileMapComponent extends PositionComponent with HasGameReference {
  late TiledComponent tiledMap;

  @override
  void onLoad() async {
    tiledMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    final objGroup = tiledMap.tileMap.getLayer<ObjectGroup>("ground");
    for (final obj in objGroup!.objects) {
      add(
        Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y),
        ),
      );
    }
    add(tiledMap);
  }
}
