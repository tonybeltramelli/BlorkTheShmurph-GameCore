package com.gobelins.DarkUnicorn {
	import flashx.textLayout.formats.TextAlign;

	import com.gobelins.DarkUnicorn.core.display.element.IAsset;
	import com.gobelins.DarkUnicorn.display.assets.CoinAsset;
	import com.gobelins.DarkUnicorn.display.assets.HeroAsset;
	import com.gobelins.DarkUnicorn.display.assets.MapAsset;
	import com.tonybeltramelli.lib.debug.AppPerf;
	import com.tonybeltramelli.lib.display.stage.STAGE;
	import com.tonybeltramelli.lib.text.TextStyle;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;

	public class DarkUnicornGameCore extends Sprite {
		private var _game : Game;
		private var _debug : AppPerf;
		private var _textFieldScore : TextField;
		
		public function DarkUnicornGameCore()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 30;
			
			STAGE = stage;

			var assets : Vector.<IAsset> = new Vector.<IAsset>();
			assets[0] = new MapAsset();
			// --- generated --- //
			assets[1] = new CoinAsset(18, -78);
			assets[2] = new CoinAsset(74, -18);
			assets[3] = new CoinAsset(-90, 56);
			assets[4] = new CoinAsset(156, 240);
			assets[5] = new CoinAsset(124, 318);
			assets[6] = new CoinAsset(-70, 248);
			assets[7] = new CoinAsset(286, 178);
			assets[8] = new CoinAsset(168, 156);
			assets[9] = new CoinAsset(196, -154);
			assets[10] = new CoinAsset(376, -18);
			assets[11] = new CoinAsset(640, -154);
			assets[12] = new CoinAsset(718, 56);
			assets[13] = new CoinAsset(484, -186);
			assets[14] = new CoinAsset(484, 210);
			assets[15] = new CoinAsset(484, 98);
			// ------ //
			assets[16] = new HeroAsset();
			
			_game = new Game(assets);
			addChild(_game.container);
			
			_debug = new AppPerf();
			addChild(_debug);
			
			_textFieldScore = new TextField();
			TextStyle.apply(_textFieldScore, "_sans", "", TextAlign.LEFT, 24, "#000000");
			_textFieldScore.y = 50;
			addChild(_textFieldScore);
			
			_startGame();
		}
		
		private function _startGame() : void
		{
			addEventListener(Event.ENTER_FRAME, _update);
		}

		private function _update(event : Event) : void
		{
			_game.update();
			_textFieldScore.text = "Score : "+_game.score;
			
			_debug.x = stage.stageWidth - _debug.width;
		}
	}
}
