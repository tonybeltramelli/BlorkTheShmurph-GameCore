package com.gobelins.DarkUnicorn {
	import com.gobelins.DarkUnicorn.core.display.Renderer;
	import com.gobelins.DarkUnicorn.core.display.element.AAsset;
	import com.gobelins.DarkUnicorn.core.display.element.IAsset;
	import com.gobelins.DarkUnicorn.core.engine.GameEngine;
	import com.gobelins.DarkUnicorn.core.entity.EntityController;
	import com.tonybeltramelli.lib.display.stage.STAGE;

	import flash.display.Sprite;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Game {
		private var _gameEngine : GameEngine;
		private var _renderer : Renderer;
		private var _container : Sprite;
		private var _score : Number = 0;

		public function Game(assets : Vector.<IAsset>)
		{
			_container = new Sprite();

			const L : int = assets.length;
			var entitiesControllers : Vector.<EntityController> = new Vector.<EntityController>(L, true);
			while ( --L != -1 )
			{
				entitiesControllers[L] = AAsset(assets[L]).entityController;
				_container.addChild(AAsset(assets[L]));
			}

			_renderer = new Renderer(assets);
			_gameEngine = new GameEngine(entitiesControllers);
		}

		public function update() : void
		{
			_gameEngine.update(_renderer.mapCollisions, _renderer.elementCollisions);
			_renderer.render();

			_container.x = -_renderer.heroPosition.x + STAGE.stageWidth / 2;
			_container.y = -_renderer.heroPosition.y + STAGE.stageHeight / 2;
			
			const L : int = _container.numChildren;
			while ( --L != -1 )
			{
				var asset : AAsset = AAsset(_container.getChildAt(L));
				if(asset.hidden)
				{
					_container.removeChild(asset);
					_score ++;
				}
			}
		}

		public function get container() : Sprite {
			return _container;
		}

		public function get score() : Number {
			return _score;
		}
	}
}
