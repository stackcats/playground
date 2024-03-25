import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ground extends PositionComponent {
  Ground({required super.size, required super.position}) {
    debugMode = true;
    add(RectangleHitbox());
  }
}
