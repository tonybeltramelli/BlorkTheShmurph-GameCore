package com.tonybeltramelli.lib.control.keyboard {
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class KeyHandler extends EventDispatcher {
		private var _target : EventDispatcher;
		private var _keys : Vector.<uint>;

		public function KeyHandler() {
		}

		public function init(target : EventDispatcher, keys : Vector.<uint>) : void {
			_target = target;
			_keys = keys;
			
			_target.addEventListener(KeyboardEvent.KEY_DOWN, _keyHandler);
			_target.addEventListener(KeyboardEvent.KEY_UP, _keyHandler);
		}

		private function _keyHandler(event : KeyboardEvent) : void
		{		
			var n: int = _keys.length;
			while( --n != -1 )
			{
				if (event.keyCode == _keys[n])
				{				
					var e : KeyEvent  = new KeyEvent(KeyEvent.KEY_MATCH);
					e.key = _keys[n];
					e.state = event.type == KeyboardEvent.KEY_DOWN;
					dispatchEvent(e);
				}
			}
		}
		
		public function clean() : void
		{
			_target.removeEventListener(KeyboardEvent.KEY_DOWN, _keyHandler);
			_target.removeEventListener(KeyboardEvent.KEY_UP, _keyHandler);
			
			_target = null;
			_keys = null;
		}
	}
}
