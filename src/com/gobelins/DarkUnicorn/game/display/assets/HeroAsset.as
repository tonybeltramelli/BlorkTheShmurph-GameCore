package com.gobelins.DarkUnicorn.game.display.assets {
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;

	import starling.display.DisplayObject;
	import starling.display.MovieClip;

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
		
		public function HeroAsset()
		{			
			super(new HeroEntity());
			
			_blinkNumber = 0;
			_hitted = false;
			//_bitmap = HeroBitmap;
			
			_movieClip = new MovieClip(SpriteSheet.getAtlas().getTextures("hero_"), 20);
			_movieClip.stop();
			_movieClip.pivotX = _movieClip.width/2;
			_movieClip.pivotY = _movieClip.height/2;
			
			_body = new Body(BodyType.DYNAMIC, new Vec2(0, 0));
			_body.shapes.add((new Circle(_movieClip.height/2 - 6, null, new Material(0.9))));
			_body.graphic = _movieClip;
		}
		
		public function hit() : void
		{
			_hitted = true;
			_blinkE();
		}
		
		private function _blinkF() : void
		{
			if(_blinkNumber < 5)
			{
				TweenLite.to(DisplayObject(_body.graphic), 0.2, {alpha: 1, onComplete: _blinkE});
			}else{
				TweenLite.to(DisplayObject(_body.graphic), 0.2, {alpha: 1});
				_blinkNumber = 0;
				_hitted = false;
			}
			_blinkNumber ++;
		}
		
		private function _blinkE() : void
		{
			TweenLite.to(DisplayObject(_body.graphic), 0.2, {alpha:0, onComplete:_blinkF});
		}

		public function get hitted() : Boolean {
			return _hitted;
		}
	}
}
