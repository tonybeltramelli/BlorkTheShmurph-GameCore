package com.gobelins.DarkUnicorn.core.entity {
	import com.gobelins.DarkUnicorn.Config;
	import com.gobelins.DarkUnicorn.core.action.Action;
	import com.gobelins.DarkUnicorn.core.engine.collision.RecordedCollision;
	import com.tonybeltramelli.lib.utils.math.Converter;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class EntityController {
		private var _entity : AEntity;
		//
		private var _upDown : Number;
		private var _rightLeft : Number;
		private var _vx : Number;
		private var _vy : Number;

		public function EntityController(entity : AEntity)
		{
			_entity = entity;
			_upDown = _rightLeft = 0;
			_vx = _vy = 0;
		}
		
		public function compute(action : Action, collision : RecordedCollision) : void
		{
			if (action.up) _upDown--;
			if (action.right) _rightLeft++;
			if (action.down) _upDown++;
			if (action.left) _rightLeft--;

			if (!action.up && !action.down && _upDown != 0)
			{
				_upDown < 0 ? _upDown += 0.5 : _upDown > 0 ? _upDown -= 0.5 : _upDown;
			}

			if (!action.right && !action.left && _rightLeft != 0)
			{
				_rightLeft < 0 ? _rightLeft += 0.5 : _rightLeft > 0 ? _rightLeft -= 0.5 : _rightLeft;
			}
			
			if (_entity.toMoveWithInteractions)
			{
				_entity.impactX = 0;
				_entity.impactY = 0;
					
				if (collision)
				{
					var angle : Number = collision.angle;
					var overlap : int = collision.overlapping.length;

					var sin : Number = Math.sin(angle);
					var cos : Number = Math.cos(angle);
					
					var vx0 : Number = _vx * cos + _vy * sin;
					var vy0 : Number = _vy * cos - _vx * sin;
					
					_vx = vx0 * cos - vy0 * sin;
					_vy = vy0 * cos + vx0 * sin;

					_vx -= cos * overlap / 10;
					_vy -= sin * overlap / 10;

					_upDown *= Config.BODY_FRICTION;
					_rightLeft *= Config.BODY_FRICTION;
					
					_entity.angle = Converter.rad2deg(angle);
					
					_entity.impactX = collision.impact.x - _entity.x;
					_entity.impactY = collision.impact.y - _entity.y;
				}
				
				_vy *= Config.AIR_FRICTION;
				_vx *= Config.AIR_FRICTION;

				_vy < 0 ? _vy += 0.5 : _vy > 0 ? _vy -= 0.5 : _vy;
				_vx < 0 ? _vx += 0.5 : _vx > 0 ? _vx -= 0.5 : _vx;

				_entity.y += _upDown + (_vy * Config.BODY_FRICTION);
				_entity.x += _rightLeft + (_vx * Config.BODY_FRICTION);

				_entity.toUpdate = true;
			}
		}
		
		public function remove() : void
		{
			_entity.toHide = true;
		}
		
		public function get toCollide() : Boolean
		{
			return _entity.toMoveWithInteractions;
		}
	}
}
