package com.gobelins.DarkUnicorn {
	import starling.display.Sprite;
	import starling.events.Event;

	import com.gobelins.DarkUnicorn.game.Game;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.HeroAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.MapAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.coin.CoinAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.coin.CoinType;
	import com.gobelins.DarkUnicorn.game.display.assets.enemy.EnemyAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.enemy.EnemyType;

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
			assets.push(new MapAsset(-219, -192, 68.1, 312.55));
			assets.push(new MapAsset(90, -36, 78.1, 78.1));
			assets.push(new MapAsset(244, -272, 44.05, 336.5));
			assets.push(new MapAsset(413, -100, 188.3, 111.8));
			assets.push(new MapAsset(537, 132, 256.35, 80.15));
			assets.push(new MapAsset(214, 299, 292.45, 72.1));
			assets.push(new MapAsset(-180, 362, 328.05, 72.1));
			assets.push(new MapAsset(685, -437, 44.05, 336.5));
			assets.push(new MapAsset(837, -148, 44.05, 336.5));
			assets.push(new MapAsset(160, 361, 44.05, 336.5));
			assets.push(new MapAsset(-563, -220, 154.6, 72.1));
			assets.push(new MapAsset(-71, -552, 356.95, 72.1));
			assets.push(new MapAsset(621, -736, 44.05, 336.5));
			assets.push(new MapAsset(-132, -508, 44.05, 336.5));
			assets.push(new MapAsset(-393, -220, 154.6, 72.1));
			assets.push(new MapAsset(-620, -144, 44.05, 336.5));
			assets.push(new MapAsset(-570, 198, 44.05, 336.5));
			assets.push(new MapAsset(-519, 511, 292.45, 72.1));
			assets.push(new MapAsset(741, -220, 188.3, 64.05));
			assets.push(new MapAsset(515, 332, 256.35, 80.15));
			assets.push(new MapAsset(-13, 142, 78.1, 78.1));
			assets.push(new MapAsset(-453, 18, 78.1, 78.1));
			assets.push(new MapAsset(74, -384, 78.1, 78.1));
			assets.push(new MapAsset(361, -360, 78.1, 78.1));
			assets.push(new MapAsset(-219, 442, 78.1, 78.1));
			assets.push(new MapAsset(889, 125, 88.15, 175.5));
			assets.push(new MapAsset(781, 332, 44.05, 336.5));
			assets.push(new MapAsset(781, 678, 328.05, 72.1));
			assets.push(new MapAsset(929, 489, 78.1, 78.1));
			assets.push(new MapAsset(955, 308, 154.6, 72.1));
			assets.push(new MapAsset(1119, 361, 44.05, 336.5));
			assets.push(new MapAsset(308, -820, 356.95, 72.1));
			assets.push(new MapAsset(252, -804, 44.05, 236.15));
			assets.push(new MapAsset(429, -606, 78.1, 78.1));
			// ------ //
			assets.push(new CoinAsset(18, -342, CoinType.BRONZE));
			assets.push(new CoinAsset(142, 186, CoinType.BRONZE));
			assets.push(new CoinAsset(266, 276, CoinType.BRONZE));
			assets.push(new CoinAsset(-370, 468, CoinType.SILVER));
			assets.push(new CoinAsset(-274, 468, CoinType.BRONZE));
			assets.push(new CoinAsset(-294, 44, CoinType.BRONZE));
			assets.push(new CoinAsset(784, 86, CoinType.BRONZE));
			assets.push(new CoinAsset(-470, 468, CoinType.BRONZE));
			assets.push(new CoinAsset(116, -434, CoinType.SILVER));
			assets.push(new CoinAsset(784, 26, CoinType.BRONZE));
			assets.push(new CoinAsset(534, -186, CoinType.BRONZE));
			assets.push(new CoinAsset(784, -106, CoinType.BRONZE));
			assets.push(new CoinAsset(534, -328, CoinType.BRONZE));
			assets.push(new CoinAsset(664, 276, CoinType.BRONZE));
			assets.push(new CoinAsset(784, -38, CoinType.BRONZE));
			assets.push(new CoinAsset(-538, -106, CoinType.BRONZE));
			assets.push(new CoinAsset(206, -342, CoinType.BRONZE));
			assets.push(new CoinAsset(116, -256, CoinType.SILVER));
			assets.push(new CoinAsset(1058, 622, CoinType.GOLD));
			assets.push(new CoinAsset(266, 86, CoinType.GOLD));
			assets.push(new CoinAsset(332, 276, CoinType.SILVER));
			assets.push(new CoinAsset(400, 276, CoinType.BRONZE));
			assets.push(new CoinAsset(464, 276, CoinType.SILVER));
			assets.push(new CoinAsset(-410, -44, CoinType.GOLD));
			assets.push(new CoinAsset(886, 448, CoinType.SILVER));
			assets.push(new CoinAsset(1058, 448, CoinType.BRONZE));
			assets.push(new CoinAsset(886, 622, CoinType.BRONZE));
			assets.push(new CoinAsset(564, -564, CoinType.GOLD));
			assets.push(new CoinAsset(-370, 296, CoinType.GOLD));
			assets.push(new CoinAsset(376, -706, CoinType.SILVER));
			assets.push(new CoinAsset(508, -706, CoinType.SILVER));
			assets.push(new CoinAsset(442, -706, CoinType.SILVER));
			assets.push(new CoinAsset(574, -706, CoinType.SILVER));
			// ------ //
			assets.push(new EnemyAsset(534, -257, EnemyType.RED_MONSTER));
			assets.push(new EnemyAsset(-370, 378, EnemyType.RED_MONSTER));
			assets.push(new EnemyAsset(484, 177, EnemyType.GREEN_MONSTER));
			assets.push(new EnemyAsset(968, 628, EnemyType.GREY_MONSTER));
			assets.push(new EnemyAsset(-188, 177, EnemyType.GREEN_MONSTER));
			assets.push(new EnemyAsset(130, -125, EnemyType.GREEN_MONSTER));
			assets.push(new EnemyAsset(-522, 149, EnemyType.GREEN_MONSTER));
			assets.push(new EnemyAsset(372, -449, EnemyType.GREY_MONSTER));
			assets.push(new EnemyAsset(558, -449, EnemyType.GREY_MONSTER));
			// ------ //
			assets.push(new HeroAsset());

			_game = new Game(assets);
			_game.addEventListener(GameEvent.UPDATE, _updateScore);
			addChild(_game.mainContainer);
			
			_startGame();
		}

		private function _updateScore(event : GameEvent) : void
		{
			dispatchEvent(new GameEvent(GameEvent.UPDATE));
		}

		private function _startGame() : void
		{
			addEventListener(Event.ENTER_FRAME, _update);
		}

		private function _update(event : Event) : void
		{
			_game.update();
		}

		public function pause() : void
		{
			_game.pause();
		}

		public function reStart() : void
		{
			_game.reStart();
		}
		
		public function clean() : void
		{
			_game.clean();
		}
		
		public function get score() : Number
		{
			return _game.score;
		}
	}
}
