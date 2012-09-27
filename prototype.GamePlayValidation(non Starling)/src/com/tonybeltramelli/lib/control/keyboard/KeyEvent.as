package com.tonybeltramelli.lib.control.keyboard {
	import flash.events.Event;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class KeyEvent extends Event {
		public static const KEY_COMBO_MATCH : String = "key_combo_match";
		public static const KEY_MATCH : String = "key_match";
		//
		public var key : uint;
		public var state : Boolean; 

		public function KeyEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
