package com.gobelins.DarkUnicorn {
	import starling.events.Event;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class GameEvent extends Event {
		public static const UPDATE : String = "update";

		public function GameEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
