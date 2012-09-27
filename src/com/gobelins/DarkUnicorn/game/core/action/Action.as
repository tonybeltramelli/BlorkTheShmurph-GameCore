package com.gobelins.DarkUnicorn.game.core.action {
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Action {
		private var _up : Boolean;
		private var _right : Boolean;
		private var _down : Boolean;
		private var _left : Boolean;

		public function Action()
		{
			_up = _right = _down = _left = false;
		}
		
		public function startAction(code : uint) : void
		{
			switch(code)
			{
				case 37:
					_left = true;
				break;
				case 38:
					_up = true;
				break;
				case 39:
					_right = true;
				break;
				case 40:
					_down = true;
				break;
			}
		}
		
		public function accelerate(xValue : Number, yValue : Number) : void
		{
			_right = xValue < 0;
			trace("--> _right : "+_right);
			_left = xValue > 0;
			trace("--> _left : "+_left);
			_up  = yValue < 0;
			trace("--> _up : "+_up);
			_down = yValue > 0;
			trace("--> _down : "+_down);
		}
		
		public function stopAction(code : uint) : void
		{
			switch(code)
			{
				case 37:
					_left = false;
				break;
				case 38:
					_up = false;
				break;
				case 39:
					_right = false;
				break;
				case 40:
					_down = false;
				break;
			}
		}
		
		public function get up() : Boolean {
			return _up;
		}

		public function get right() : Boolean {
			return _right;
		}

		public function get down() : Boolean {
			return _down;
		}

		public function get left() : Boolean {
			return _left;
		}
	}
}
