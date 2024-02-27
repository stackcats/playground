import 'package:flame/sprite.dart';

extension CreateAnimationByLimit on SpriteSheet {
  SpriteAnimation createAnimationByLimit({
    required int xInit,
    required int yInit,
    required int step,
    required int sizeX,
    required double stepTime,
    bool loop = true,
  }) {
    final List<Sprite> spriteList = [];
    int x = xInit;
    int y = yInit;
    for (int i = 0; i < step; i++) {
      spriteList.add(getSprite(x, y));
      y++;
      if (y >= sizeX) {
        y = 0;
        x++;
      }
    }
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}
