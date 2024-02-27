import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:game/utils/create_animation_by_limit.dart';
import 'package:flutter/services.dart';

class PlayerImageSpriteComponent extends SpriteAnimationComponent
    with HasGameReference, KeyboardHandler, TapCallbacks {
  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteWidth = 680;
  final double spriteHeight = 472;

  late SpriteAnimation deadAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation walkAnimation;

  late List<SpriteAnimation> animations = [];

  bool right = true;

  int animationIndex = 0;

  @override
  void onLoad() async {
    // sprite = await Sprite.load('tiger.png');
    super.onLoad();
    anchor = Anchor.center;

    final spriteImage = await Flame.images.load("dinofull.png");
    final spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    const sizeX = 6;

    deadAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 8,
      sizeX: sizeX,
      stepTime: 0.08,
    );

    idleAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 2,
      step: 10,
      sizeX: sizeX,
      stepTime: 0.08,
    );

    jumpAnimation = spriteSheet.createAnimationByLimit(
      xInit: 3,
      yInit: 0,
      step: 12,
      sizeX: sizeX,
      stepTime: 0.08,
    );

    runAnimation = spriteSheet.createAnimationByLimit(
      xInit: 5,
      yInit: 0,
      step: 8,
      sizeX: sizeX,
      stepTime: 0.08,
    );

    walkAnimation = spriteSheet.createAnimationByLimit(
      xInit: 6,
      yInit: 2,
      step: 10,
      sizeX: sizeX,
      stepTime: 0.08,
    );

    animations = <SpriteAnimation>[
      deadAnimation,
      idleAnimation,
      jumpAnimation,
      walkAnimation,
      runAnimation
    ];

    animation = idleAnimation;

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    size = Vector2(spriteWidth, spriteHeight);
    centerX = screenWidth / 2;
    centerY = screenHeight / 2;
    position = Vector2(centerX, centerY);
  }

  @override
  void update(double dt) {
    // position = Vector2(centerX++, centerY++);
    super.update(dt);
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.isEmpty) {
      animation = idleAnimation;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      position.x -= 80;
      if (right) {
        flipHorizontally();
      }
      right = false;
      animation = walkAnimation;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      position.x += 80;
      if (!right) {
        flipHorizontally();
      }
      right = true;
      animation = walkAnimation;
    }
    return true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    print("tap down ${event}");
    super.onTapDown(event);
    animationIndex = (animationIndex + 1) % animations.length;
    animation = animations[animationIndex];
  }

  @override
  void onTapUp(TapUpEvent event) {
    print("tap down ${event}");
    super.onTapUp(event);
  }
}
