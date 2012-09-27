package com.gobelins.DarkUnicorn.core.display.element {
	import com.gobelins.DarkUnicorn.core.entity.AEntity;
	import com.gobelins.DarkUnicorn.core.entity.EntityController;
	import com.greensock.TweenLite;

	import flash.display.Sprite;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AAsset extends Sprite {
		protected var _entity : AEntity;
		protected var _toHide : Boolean;
		//
		private var _entityController : EntityController;
		private var _hidden : Boolean;
		
		public function AAsset(entity : AEntity)
		{
			_entityController = new EntityController(entity);
			_entity = entity;
			
			_toHide = false;
			_hidden = false;
			
			_show();
		}
		
		protected function _show() : void
		{
			TweenLite.from(this, 0.3, {alpha: 0});
		}
		
		public function render() : void
		{
			x = _entity.x;
			y = _entity.y;
		}
		
		protected function _hide() : void
		{
			if(!_toHide)
			{
				_toHide = true;
				TweenLite.to(this, 0.3, {alpha: 0, onComplete: _toRemove});
			}
		}
		
		protected function _toRemove() : void
		{
			_hidden = true;
		}

		public function get entityController() : EntityController {
			return _entityController;
		}

		public function get isHero() : Boolean {
			return _entity.toMoveWithInteractions;
		}
		
		public function get isMap() : Boolean {
			return _entity.isMainCollider;
		}

		public function get hidden() : Boolean {
			return _hidden;
		}
	}
}
