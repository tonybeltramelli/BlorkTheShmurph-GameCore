package com.gobelins.DarkUnicorn.game.core.display {
	import nape.phys.Body;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;

	import com.gobelins.DarkUnicorn.game.core.entity.AEntity;
	import com.greensock.TweenLite;

	import flash.media.Sound;




	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AAsset {
		protected var _entity : AEntity;
		protected var _body : Body;
		protected var _image : Image;
		protected var _movieClip : MovieClip;
		protected var _valueImage : Image;
		protected var _sound : Sound;
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
		
		public function showValue(container : Sprite) : void
		{
			container.addChild(_valueImage);
			_valueImage.x = _body.position.x + 10;
			_valueImage.y = _body.position.y;
			TweenLite.to(_valueImage, 1, {delay: 0.3, alpha: 0, scaleX: 2, scaleY: 2, onComplete: _removeValue, onCompleteParams: [container]});
		}
		
		public function _removeValue(container : Sprite) : void
		{
			container.removeChild(_valueImage);
		}
		
		public function toRemove() : void
		{
			if(!_gonnaBeRemoved)
			{
				_gonnaBeRemoved = true;
				TweenLite.to(DisplayObject(_body.graphic), 0.3, {scaleX: 2, scaleY: 2, alpha: 0, onComplete: _hideIt});
			}
		}
		
		private function _hideIt() : void
		{
			_toDelete = true;
		}
		
		public function clean() : void
		{
			_image = null;
			_movieClip = null;
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

		public function get movieClip() : MovieClip {
			return _movieClip;
		}

		public function get entity() : AEntity {
			return _entity;
		}
	}
}
