import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_example/bullet.dart';
import 'package:flame_example/explosion.dart';
import 'package:flame_example/game.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );

  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      FlameAudio.play('d.mp3');
      game.add(Explosion(position: position));
    }
  }
}
