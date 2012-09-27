package com.gobelins.DarkUnicorn.core.action.manager {
	import com.gobelins.DarkUnicorn.core.action.Action;
	import com.tonybeltramelli.lib.control.keyboard.KeyEvent;
	import com.tonybeltramelli.lib.control.keyboard.KeyHandler;
	import com.tonybeltramelli.lib.display.stage.STAGE;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ActionManager {
		private var _keyHandler : KeyHandler;
		private var _action : Action;
		
		public function ActionManager()
		{
			_action = new Action();
		}
		
		public function init() : void
		{
			_keyHandler = new KeyHandler();
			_keyHandler.addEventListener(KeyEvent.KEY_MATCH, _keyMatch);
			_keyHandler.init(STAGE, new <uint>[37, 38, 39, 40]);
		}

		private function _keyMatch(event : KeyEvent) : void
		{	
			if(event.state)
			{
				_action.startAction(event.key);		
			}else{
				_action.stopAction(event.key);
			}
		}
		
		public function clean() : void
		{
			_keyHandler.removeEventListener(KeyEvent.KEY_MATCH, _keyMatch);
			_keyHandler.clean();
			_keyHandler = null;
		}

		public function get action() : Action {
			return _action;
		}
	}
}
