package com.tonybeltramelli.lib.display {
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AMovieClip extends MovieClip
	{
		private var _toResize : Boolean;

		public function AMovieClip(toResize : Boolean = false) {
			this._toResize = toResize;
			addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
		}
		
		private function _addedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _removedFromStage);
			if(_toResize) stage.addEventListener(Event.RESIZE, _resizeHandler);
			_onStage();
		}
		
		private function _removedFromStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, _removedFromStage);
			if(_toResize) stage.removeEventListener(Event.RESIZE, _resizeHandler);
			_outStage();
		}
		
		private function _resizeHandler(event : Event) : void {
			_onResize();
		}
		
		protected function _onStage() : void {}
		
		protected function _onResize() : void {}
		
		protected function _outStage() : void {}
	}
}
