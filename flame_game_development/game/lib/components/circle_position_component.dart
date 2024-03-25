import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/palette.dart';

class CirclePositionComponent extends PositionComponent
    with HasGameReference, CollisionCallbacks {
  static const int circleSpeed = 200;
  static const circleWidth = 100.0;
  static const circleHeight = 100.0;

  int circleDirectionX = 1;
  int circleDirectionY = 1;
  late double screenWidth;
  late double screenHeight;
  late double centerX;
  late double centerY;

  final ShapeHitbox hitbox = CircleHitbox();
  Random random = Random();

  @override
  void onLoad() async {
    super.onLoad();

    circleDirectionX = random.nextBool() ? 1 : -1;
    circleDirectionY = random.nextBool() ? 1 : -1;

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    centerX = screenWidth / 2 - circleWidth / 2;
    centerY = screenHeight / 2 - circleWidth / 2;
    position = Vector2(random.nextDouble() * screenWidth, -circleHeight);
    size = Vector2(circleWidth, circleHeight);
    hitbox.paint.color = BasicPalette.green.color;
    hitbox.renderShape = true;
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += circleSpeed * circleDirectionY * dt;
    if (position.y >= screenHeight) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {}

    if (other is CirclePositionComponent) {}
  }
}
