import 'package:flame/components.dart';

class BackgroundImageComponent extends SpriteComponent with HasGameReference {
  @override
  void onLoad() async {
    position = Vector2(0, 0);
    sprite = await Sprite.load('background.jpg');
    // size = game.size;
    size = sprite!.originalSize;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
