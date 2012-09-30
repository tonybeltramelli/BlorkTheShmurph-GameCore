package com.gobelins.DarkUnicorn.game.core.action.manager {
	import nape.geom.Vec2;
	import nape.space.Space;

	import starling.events.TouchEvent;

	import com.gobelins.DarkUnicorn.game.control.keyboard.KeyEvent;
	import com.gobelins.DarkUnicorn.game.control.keyboard.KeyHandler;
	import com.gobelins.DarkUnicorn.game.core.action.Action;
	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.stage.STAGE;

	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ActionManager {
		private var _keyHandler : KeyHandler;
		private var _accelerometer : Accelerometer;
		private var _action : Action;
		//
		private var _upDown : Number;
		private var _rightLeft : Number;
		private var _spaceReference : Space;
		private var _hero : AAsset;

		public function ActionManager(space : Space, hero : AAsset)
		{
			_spaceReference = space;
			_hero = hero;
			_upDown = _rightLeft = 0;

			_action = new Action();
			
			STAGE.addEventListener(TouchEvent.TOUCH, _tapHandler);
		}

		private function _tapHandler(event : TouchEvent) : void
		{
			_hero.body.graphic.x = _hero.body.position.x = 0
			_hero.body.graphic.y = _hero.body.position.y = 0;
		}

		public function init() : void
		{
			_keyHandler = new KeyHandler();
			_keyHandler.addEventListener(KeyEvent.KEY_MATCH, _keyMatch);
			_keyHandler.init(STAGE, new <uint>[37, 38, 39, 40]);

			trace("------> Accelerometer.isSupported : " + Accelerometer.isSupported);
			if (Accelerometer.isSupported)
			{
				_accelerometer = new Accelerometer();
				_accelerometer.addEventListener(AccelerometerEvent.UPDATE, _onAcceleration);
			}
		}

		private function _keyMatch(event : KeyEvent) : void
		{
			if (event.state)
			{
				_action.startAction(event.key);
			} else {
				_action.stopAction(event.key);
			}

			_compute();
		}

		private function _onAcceleration(event : AccelerometerEvent) : void
		{
			_rightLeft = -event.accelerationX * 100;
			_upDown = event.accelerationY * 100;
			
			_compute();
		}

		private function _compute() : void
		{
			if (!Accelerometer.isSupported)
			{
				if (_action.up) _upDown--;
				if (_action.right) _rightLeft++;
				if (_action.down) _upDown++;
				if (_action.left) _rightLeft--;

				if (!_action.up && !_action.down && _upDown != 0)
				{
					_upDown < 0 ? _upDown += 0.5 : _upDown > 0 ? _upDown -= 0.5 : _upDown;
				}

				if (!_action.right && !_action.left && _rightLeft != 0)
				{
					_rightLeft < 0 ? _rightLeft += 0.5 : _rightLeft > 0 ? _rightLeft -= 0.5 : _rightLeft;
				}
			}

			_spaceReference.gravity = new Vec2(_rightLeft * 50, _upDown * 50);
		}

		public function clean() : void
		{
			if( _keyHandler ){
				_keyHandler.removeEventListener(KeyEvent.KEY_MATCH, _keyMatch);
				_keyHandler.clean();
				_keyHandler = null;
			}
			
			STAGE.removeEventListener(TouchEvent.TOUCH, _tapHandler); 
		}
	}
}
