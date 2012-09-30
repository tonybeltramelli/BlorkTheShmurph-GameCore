package com.tonybeltramelli.lib.display {

	import flash.events.MouseEvent;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AButton extends AMovieClip {

		private var _enabled : Boolean = true;

		public function AButton()
		{
			super();
		}
		
		protected override function _onStage() : void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, _onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, _onOut);
			this.addEventListener(MouseEvent.CLICK, _onClick);

			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseEnabled = true;
			this.mouseChildren = false;
		}
		
		protected override function _outStage() : void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER, _onOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, _onOut);
			this.removeEventListener(MouseEvent.CLICK, _onClick);
		}
		
		protected function _onOver(event : MouseEvent) : void
		{
			if(_enabled) gotoAndPlay("over");
		}

		protected function _onOut(event : MouseEvent) : void
		{
			if (_enabled) gotoAndPlay("out");
		}
		
		protected function _onClick(event : MouseEvent) : void
		{
		}
		
		public function setEnabled(enabled : Boolean) : void
		{
			_enabled = enabled;
		}
	}
}
