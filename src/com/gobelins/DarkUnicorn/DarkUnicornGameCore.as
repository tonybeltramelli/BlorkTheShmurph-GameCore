package com.gobelins.DarkUnicorn {
	import com.gobelins.DarkUnicorn.api.IGameCore;
	import com.gobelins.DarkUnicorn.game.stage.STAGE;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import starling.core.Starling;

	[SWF(frameRate=60, width=800, height=600, backgroundColor=0xFFFFFF)]
	public class DarkUnicornGameCore extends Sprite implements IGameCore {
		private var _starling : Starling;

		public function DarkUnicornGameCore()
		{
			addEventListener(Event.ADDED_TO_STAGE, _build);
		}

		private function _build(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _build);

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			_starling = new Starling(Main, stage);

			STAGE = _starling.stage;
			
			_starling.start();
		}

		public function start() : void
		{
			(_starling.root as Main).reStart();
		}

		public function startAt(l : Number) : void
		{
			(_starling.root as Main).reStart();
		}

		public function pause() : void
		{
			(_starling.root as Main).pause();
		}
	}
}
