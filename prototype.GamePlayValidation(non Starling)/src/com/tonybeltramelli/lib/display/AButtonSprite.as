package com.tonybeltramelli.lib.display {

	import flash.events.MouseEvent;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AButtonSprite extends ASprite
	{
		public function AButtonSprite()
		{
			super();
		}
		
		protected override function _onStage() : void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			this.addEventListener(MouseEvent.CLICK, _clickHandler);
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseEnabled = true;
			this.mouseChildren = false;
		}
		
		protected override function _outStage() : void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			this.removeEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _overHandler(event : MouseEvent) : void
		{
			_onOver();
		}

		private function _outHandler(event : MouseEvent) : void
		{
			_onOut();
		}
		
		private function _clickHandler(event : MouseEvent) : void
		{
			_onClick();
		}
		
		protected function _onOver() : void {}
		
		protected function _onOut() : void {}
		
		protected function _onClick() : void {}
	}
}
