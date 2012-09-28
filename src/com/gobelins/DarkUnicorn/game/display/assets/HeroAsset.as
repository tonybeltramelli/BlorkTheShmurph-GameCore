package com.gobelins.DarkUnicorn.game.display.assets {
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;

	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.display.texture.SpriteSheet;
	import com.gobelins.DarkUnicorn.game.entities.HeroEntity;
	import com.greensock.TweenLite;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class HeroAsset extends AAsset implements IAsset {
		private var _blinkNumber : int;
		private var _hitted : Boolean;
		private var _particles : PDParticleSystem;

		public function HeroAsset()
		{
			super(new HeroEntity());

			_blinkNumber = 0;
			_hitted = false;
			// _bitmap = HeroBitmap;

			_movieClip = new MovieClip(SpriteSheet.getAtlas().getTextures("hero_"), 20);
			_movieClip.stop();
			_movieClip.pivotX = _movieClip.width / 2;
			_movieClip.pivotY = _movieClip.height / 2;

			_body = new Body(BodyType.DYNAMIC, new Vec2(0, 0));
			_body.shapes.add((new Circle(_movieClip.height / 2 - 6, null, new Material(0.9))));
			_body.graphic = _movieClip;

			_particles = new PDParticleSystem(XML(new SpriteSheet.ParticleConfig()), Texture.fromBitmap(new SpriteSheet.ParticleTexture()));
		}

		public function hit(container : Sprite) : void
		{
			_hitted = true;
			
			_particles.start();
			container.addChild(_particles);
			
			_particles.x = _body.position.x;
			_particles.y = _body.position.y;
			
			_blinkE(container);
		}

		private function _blinkF(container : Sprite) : void
		{
			if (_blinkNumber < 5)
			{
				TweenLite.to(DisplayObject(_body.graphic), 0.2, {alpha:1, onComplete:_blinkE, onCompleteParams: [container]});
			} else {
				TweenLite.to(DisplayObject(_body.graphic), 0.2, {alpha:1});
				
				_blinkNumber = 0;
				_hitted = false;
				
				TweenLite.to(_particles, 0.3, {alpha:0, onComplete: _removeParticle, onCompleteParams: [container]});
			}
			_blinkNumber++;
		}
		
		private function _removeParticle(container : Sprite) : void
		{
			TweenLite.to(_particles, 0, {alpha:1});
			container.removeChild(_particles);
		}

		private function _blinkE(container : Sprite) : void
		{
			TweenLite.to(DisplayObject(_body.graphic), 0.2, {alpha:0, onComplete:_blinkF, onCompleteParams: [container]});
		}

		public function get hitted() : Boolean {
			return _hitted;
		}

		public function get particles() : PDParticleSystem {
			return _particles;
		}
	}
}
