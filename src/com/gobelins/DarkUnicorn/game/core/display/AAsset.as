package com.gobelins.DarkUnicorn.game.core.display {
	import nape.phys.Body;

	import starling.display.Image;
	import starling.display.Sprite;

	import com.gobelins.DarkUnicorn.game.core.entity.AEntity;
	import com.greensock.TweenLite;




	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AAsset {
		protected var _entity : AEntity;
		protected var _body : Body;
		protected var _sprite : Sprite;
		protected var _value : Number;
		//
		private var _gonnaBeRemoved : Boolean;
		private var _toDelete : Boolean;
		
		public function AAsset(entity : AEntity)
		{
			_entity = entity;
			
			_gonnaBeRemoved = false;
			_toDelete = false;
		}
		
		public function update() : void
		{
		}
		
		public function toRemove() : void
		{
			if(!_gonnaBeRemoved)
			{
				_gonnaBeRemoved = true;
				TweenLite.to(Sprite(_body.graphic), 0.3, {scaleX: 2, scaleY: 2, alpha: 0, onComplete: _hideIt});
			}
		}
		
		private function _hideIt() : void
		{
			_toDelete = true;
		}
		
		public function clean() : void
		{
			_sprite = null;
		}
		
		protected function set _bitmap(BitmapClass : Class) : void
		{
			_sprite = new Sprite();
			_sprite.addChild(Image.fromBitmap(new BitmapClass()));
		}

		public function get isHero() : Boolean {
			return _entity.toMoveWithInteractions;
		}
		
		public function get isMap() : Boolean {
			return _entity.isMainCollider;
		}

		public function get body() : Body {
			return _body;
		}

		public function get gonnaBeRemoved() : Boolean {
			return _gonnaBeRemoved;
		}
		
		public function get toDelete() : Boolean {
			return _toDelete;
		}

		public function get value() : Number {
			return _value;
		}
	}
}
