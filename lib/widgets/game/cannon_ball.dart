import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:plinco/const/assets.dart';
import 'package:plinco/services/images_service.dart';
import 'package:plinco/widgets/game/plinco_game.dart';

class CannonBall extends SpriteComponent with HasGameRef<PlincoGame> {
  static final Vector2 ballSize = Vector2(50, 50);

  CannonBall() : super(size: ballSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final ImageComposition.Image? ballImage =
    await ImagesService().getImageByFilename(assetsMap['ball']!);

    if (ballImage != null) {
      sprite = Sprite(ballImage);
      size = ballSize;
    } else {
      print('Cannot load the ball sprite image.');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * 600 * dt;

    if (position.y < 0) {
      removeFromParent();
      gameRef.cannon.reload();
    }
  }
}
