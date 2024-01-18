import 'package:flame/components.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/plinco_game.dart';

class Cannon extends PositionComponent with HasGameRef<PlincoGame> {
  late SpriteComponent _cannonBase;
  late SpriteComponent _cannonTop;
  late SpriteComponent _cannonBall;

  Cannon() : super(anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    final ImageComposition.Image? gunBackImage =
        await ImagesService().getImageByFilename(assetsMap['gun_back']!);
    final ImageComposition.Image? gunImage =
        await ImagesService().getImageByFilename(assetsMap['gun']!);
    final ImageComposition.Image? ballImage =
        await ImagesService().getImageByFilename(assetsMap['ball']!);

    if (gunBackImage != null && gunImage != null && ballImage != null) {
      _cannonBase = SpriteComponent(
        sprite: Sprite(gunBackImage),
        size: Vector2(61, 65),
        anchor: Anchor.bottomCenter,
      );
      _cannonTop = SpriteComponent(
        sprite: Sprite(gunImage),
        size: Vector2(85, 88),
        anchor: Anchor.bottomCenter,
      );
      _cannonBall = SpriteComponent(
        sprite: Sprite(ballImage),
        size: Vector2(50, 50),
        anchor: Anchor.bottomCenter,
      );

      add(_cannonBase);
      add(_cannonBall);
      add(_cannonTop);

      _cannonBase.position.y -= 33.5;
      _cannonBall.position.y -= 10;
      position =
          Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - size.y / 2);
    } else {
      print('Error: Could not load sprites.');
    }
  }

  void move(Vector2 delta) {
    position.add(Vector2(delta.x, 0));

    double newX =
        position.x.clamp(size.x / 2, gameRef.size.x - size.x / 2).toDouble();
    position.x = newX;
  }
}
