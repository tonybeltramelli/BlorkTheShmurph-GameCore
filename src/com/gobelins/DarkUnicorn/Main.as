package com.gobelins.DarkUnicorn {
	import com.gobelins.DarkUnicorn.game.Game;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.CoinAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.HeroAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.MapAsset;
	import starling.display.Sprite;
	import starling.events.Event;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Main extends Sprite {
		private var _game : Game;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, _build);
		}

		private function _build(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _build);
			
			var assets : Vector.<IAsset> = new Vector.<IAsset>();
			assets.push(new MapAsset(-219, -192, 68.1, 384.6));
			assets.push(new MapAsset(140, -36, 78.1, 78.1));
			assets.push(new MapAsset(244, -272, 44.05, 336.5));
			assets.push(new MapAsset(413, -100, 188.3, 64.05));
			assets.push(new MapAsset(361, 96, 32.05, 124.2));
			assets.push(new MapAsset(537, 132, 256.35, 80.15));
			assets.push(new MapAsset(218, 289, 292.45, 72.1));
			assets.push(new MapAsset(-180, 362, 272.4, 72.1));
			assets.push(new MapAsset(685, -437, 44.05, 336.5));
			assets.push(new MapAsset(837, -148, 44.05, 336.5));
			assets.push(new MapAsset(152, 366, 44.05, 336.5));
			assets.push(new MapAsset(-337, 250, 154.6, 72.1));
			assets.push(new MapAsset(-15, -552, 605.75, 72.1));
			assets.push(new MapAsset(621, -736, 44.05, 336.5));
			assets.push(new MapAsset(-104, -508, 44.05, 336.5));
			assets.push(new CoinAsset(18, -78));
			assets.push(new CoinAsset(74, -18));
			assets.push(new CoinAsset(-90, 56));
			assets.push(new CoinAsset(156, 240));
			assets.push(new CoinAsset(124, 318));
			assets.push(new CoinAsset(-70, 248));
			assets.push(new CoinAsset(286, 178));
			assets.push(new CoinAsset(168, 156));
			assets.push(new CoinAsset(196, -154));
			assets.push(new CoinAsset(376, -18));
			assets.push(new CoinAsset(640, -154));
			assets.push(new CoinAsset(718, 56));
			assets.push(new CoinAsset(484, -186));
			assets.push(new CoinAsset(484, 210));
			assets.push(new CoinAsset(484, 98));
			// ------ //
			assets.push(new HeroAsset());

			_game = new Game(assets);
			addChild(_game.mainContainer);

			_startGame();
		}

		private function _startGame() : void {
			addEventListener(Event.ENTER_FRAME, _update);
		}

		private function _update(event : Event) : void {
			_game.update();
		}
	}
}
