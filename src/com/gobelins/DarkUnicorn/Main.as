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

		public function Main()
		{
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
			assets.push(new MapAsset(-563, -220, 154.6, 72.1));
			assets.push(new MapAsset(-71, -552, 679.75, 72.1));
			assets.push(new MapAsset(621, -736, 44.05, 336.5));
			assets.push(new MapAsset(-132, -508, 44.05, 336.5));
			assets.push(new MapAsset(-393, -220, 154.6, 72.1));
			assets.push(new MapAsset(-620, -144, 44.05, 336.5));
			assets.push(new MapAsset(-570, 198, 44.05, 336.5));
			assets.push(new MapAsset(-519, 511, 292.45, 72.1));
			assets.push(new MapAsset(108, 352, 32.05, 124.2));
			assets.push(new MapAsset(-218, 426, 32.05, 124.2));
			assets.push(new MapAsset(741, -220, 188.3, 64.05));
			assets.push(new MapAsset(537, 332, 256.35, 80.15));
			assets.push(new MapAsset(865, 198, 32.05, 124.2));
			assets.push(new MapAsset(803, 334, 78.1, 78.1));
			assets.push(new MapAsset(-13, 142, 78.1, 78.1));
			assets.push(new MapAsset(-453, 28, 78.1, 78.1));
			assets.push(new MapAsset(74, -384, 78.1, 78.1));
			assets.push(new MapAsset(361, -360, 78.1, 78.1));
			// ------ //
			assets.push(new CoinAsset(18, -342));
			assets.push(new CoinAsset(170, 166));
			assets.push(new CoinAsset(376, 254));
			assets.push(new CoinAsset(-370, 468));
			assets.push(new CoinAsset(-274, 468));
			assets.push(new CoinAsset(-294, 66));
			assets.push(new CoinAsset(784, 86));
			assets.push(new CoinAsset(-470, 468));
			assets.push(new CoinAsset(116, -434));
			assets.push(new CoinAsset(784, 26));
			assets.push(new CoinAsset(534, -186));
			assets.push(new CoinAsset(784, -106));
			assets.push(new CoinAsset(534, -328));
			assets.push(new CoinAsset(664, 276));
			assets.push(new CoinAsset(784, -38));
			assets.push(new CoinAsset(-410, -58));
			assets.push(new CoinAsset(206, -342));
			assets.push(new CoinAsset(116, -256));
			// ------ //
			assets.push(new HeroAsset());

			_game = new Game(assets);
			addChild(_game.mainContainer);

			_startGame();
		}

		private function _startGame() : void
		{
			addEventListener(Event.ENTER_FRAME, _update);
		}

		private function _update(event : Event) : void
		{
			_game.update();
		}
	}
}
