package com.tonybeltramelli.lib.control.keyboard {
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class KeyCombo extends EventDispatcher {
		private var _target : EventDispatcher;
		private var _keys : Vector.<uint>;
		private var _matchKeysI : int = 0;

		public function KeyCombo() {
		}

		public function init(target : EventDispatcher, keys : Vector.<uint>) : void {
			_target = target;
			_keys = keys;
			
			_target.addEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			_target.addEventListener(KeyboardEvent.KEY_UP, _keyUp);
		}

		private function _keyDown(event : KeyboardEvent) : void {
			var n: int = _keys.length;
			while( --n != -1 )
			{
				if (event.keyCode == _keys[n]) _keyMatch();
			}
		}

		private function _keyMatch() : void {
			_matchKeysI ++;
			if(_matchKeysI == _keys.length) dispatchEvent(new KeyEvent(KeyEvent.KEY_COMBO_MATCH));
		}
		
		private function _keyUp(event : KeyboardEvent) : void
		{
			_matchKeysI = 0;
		}
		
		public function clean() : void
		{
			_target.removeEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			_target.removeEventListener(KeyboardEvent.KEY_UP, _keyUp);
			
			_target = null;
			_keys = null;
		}
	}
}
