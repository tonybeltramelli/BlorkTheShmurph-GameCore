package com.gobelins.DarkUnicorn {
	import flash.events.DataEvent;
	import flashx.textLayout.formats.TextAlign;

	import net.hires.debug.Stats;

	import starling.core.Starling;
	import starling.events.Event;

	import com.gobelins.DarkUnicorn.api.IGameCore;
	import com.gobelins.DarkUnicorn.config.Config;
	import com.gobelins.DarkUnicorn.game.stage.STAGE;
	import com.greensock.TweenLite;
	import com.tonybeltramelli.lib.text.TextStyle;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	[SWF(frameRate=60, width=800, height=600, backgroundColor=0xFFFFFF)]
	public class DarkUnicornGameCore extends Sprite implements IGameCore {
		private var _starling : Starling;
		private var _stats : Stats;
		private var _textFieldScore : TextField;
		private var _textFieldTime : TextField;
		private var _textFieldInfos : TextField;
		private var _infosContainer : Sprite;
		private var _timer : Timer;
		private var _time : int;

		public function DarkUnicornGameCore()
		{
			addEventListener(flash.events.Event.ADDED_TO_STAGE, _build);
		}

		private function _build(event : flash.events.Event) : void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, _build);
			addEventListener(flash.events.Event.REMOVED_FROM_STAGE, _clean);

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			_starling = new Starling(Main, stage);

			STAGE = _starling.stage;
			
			start();
			
		}

		private function _rootCreated(event : starling.events.Event) : void
		{
			pause();
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, _rootCreated);

			_time = 3;

			_textFieldInfos = new TextField();
			TextStyle.apply(_textFieldInfos, "_sans", String(_time), TextAlign.LEFT, 100, "#e43131");

			_infosContainer = new Sprite();
			_infosContainer.addChild(_textFieldInfos);
			_infosContainer.x = stage.stageWidth / 2 - _infosContainer.width / 2;
			_infosContainer.y = stage.stageHeight / 2 - _infosContainer.height / 2;
			addChild(_infosContainer);

			_textFieldInfos.x = -_textFieldInfos.width / 2;
			_textFieldInfos.y = -_textFieldInfos.height / 2;

			TweenLite.to(_infosContainer, 1, {alpha:0, scaleX:2, scaleY:2, onComplete:_animateText});
		}

		private function _animateText() : void
		{
			TweenLite.to(_infosContainer, 0, {alpha:1, scaleX:1, scaleY:1});

			_time--;

			if (_time == -1)
			{
				removeChild(_infosContainer);
				_startGame();
			} else {
				_textFieldInfos.text = _time != 0 ? String(_time) : "Go !";
				_textFieldInfos.x = -_textFieldInfos.width / 2;
				_textFieldInfos.y = -_textFieldInfos.height / 2;
				TweenLite.to(_infosContainer, 1, {alpha:0, scaleX:2, scaleY:2, onComplete:_animateText});
			}
		}

		private function _startGame() : void
		{
			restart();
			_stats = new Stats();
			_stats.y = 200;
			addChild(_stats);

			_textFieldScore = new TextField();
			_textFieldScore.x = 5;
			TextStyle.apply(_textFieldScore, "_sans", "Score : 0", TextAlign.LEFT, 24, "#FFFFFF");
			addChild(_textFieldScore);

			_textFieldTime = new TextField();
			_textFieldTime.x = stage.stageWidth - _textFieldTime.width - 10;
			TextStyle.apply(_textFieldTime, "_sans", "Time : 0", TextAlign.LEFT, 24, "#198e16");
			addChild(_textFieldTime);

			_starling.root.addEventListener(GameEvent.UPDATE, _updateScore);

			_time = Config.TIME_TOTAL;

			_timer = new Timer(Config.TIME_INCREMENT);
			_timer.addEventListener(flash.events.TimerEvent.TIMER, _timerIncrement);
			_timer.start();
		}

		private function _timerIncrement(event : flash.events.TimerEvent) : void
		{
			_time--;

			_textFieldTime.text = "Time : " + _toSeconds(_time);

			if (parseInt(_toSeconds(_time)) < 10) TextStyle.apply(_textFieldTime, "_sans", "Time : "+_toSeconds(_time), TextAlign.LEFT, 24, "#e43131");

			if (_time == 0) _endGame();
		}

		private function _endGame() : void
		{
			_timer.removeEventListener(flash.events.TimerEvent.TIMER, _timerIncrement);
			_timer.stop();

			pause();
			(_starling.root as Main).clean();
			
			var event : DataEvent = new DataEvent(DataEvent.DATA);
			event.data = String(Main(_starling.root).score);
			dispatchEvent(event);
		}

		private function _updateScore(event : starling.events.Event) : void
		{
			_textFieldScore.text = "Score : " + Main(event.currentTarget).score;
		}

		private function _clean(event : flash.events.Event = null) : void
		{
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, _rootCreated);
			_starling.root.removeEventListener(GameEvent.UPDATE, _updateScore);
			_timer.removeEventListener(flash.events.TimerEvent.TIMER, _timerIncrement);

			removeEventListener(flash.events.Event.ADDED_TO_STAGE, _build);
			removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, _clean);

			(_starling.root as Main).clean();
		}

		public function start() : void
		{
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, _rootCreated);
			_starling.start();
		}

		public function pause() : void
		{
			(_starling.root as Main).pause();
			if (_timer) _timer.stop();
		}
		
		public function restart() : void
		{
			(_starling.root as Main).reStart();
			if (_timer) _timer.start();
		}
		
		public function clean() : void
		{
			_clean();

			_textFieldScore = null;
			_textFieldTime = null;
			_textFieldInfos = null;
			_infosContainer = null;
			_timer = null;
		}

		private function _toSeconds(milliseconds : int) : String
		{
			var s : int = milliseconds / 100;

			var result : String = String(s);
			return  result;
		}
	}
}
