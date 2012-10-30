package com.gobelins.DarkUnicorn.game {
	import com.gobelins.DarkUnicorn.GameEvent;
	import com.gobelins.DarkUnicorn.game.core.action.manager.ActionManager;
	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.display.Background;
	import com.gobelins.DarkUnicorn.game.display.MapBuilder;
	import com.gobelins.DarkUnicorn.game.display.assets.HeroAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.coin.CoinAsset;
	import com.gobelins.DarkUnicorn.game.display.assets.enemy.EnemyAsset;
	import com.gobelins.DarkUnicorn.game.stage.STAGE;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EventDispatcher;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Game extends EventDispatcher {
		private var _assets : Vector.<IAsset>;
		private var _space : Space;
		private var _actionManager : ActionManager;
		private var _hero : HeroAsset;
		private var _score : Number;
		//
		private var _mainContainer : Sprite;
		private var _container : Sprite;
		private var _isPaused : Boolean;
		private var _gameArea : MapBuilder;
		private var _background : Background;
		
		public function Game(assets : Vector.<IAsset>)
		{
			_assets = assets;
			_space = new Space(new Vec2(0, 0));

			_mainContainer = new Sprite();

			_score = 0;

			_container = new Sprite();
			_mainContainer.addChild(_container);

			_gameArea = new MapBuilder();

			const L : int = assets.length;
			while ( --L != -1 )
			{
				var assetBody : Body = AAsset(_assets[L]).body;
				assetBody.space = _space;
				if (assetBody.graphic)
				{
					if (AAsset(_assets[L]).movieClip) Starling.juggler.add(AAsset(_assets[L]).movieClip);
					if (AAsset(_assets[L]).isHero)
					{
						assetBody.graphicUpdate = _updateGraphicHero;
						Starling.juggler.add(HeroAsset(_assets[L]).particles);
					}else{
						assetBody.graphicUpdate = _updateGraphic;
					}
					_container.addChild(assetBody.graphic);
				} else {
					_gameArea.draw(AAsset(_assets[L]).entity);
				}

				if (AAsset(_assets[L]).isHero || AAsset(_assets[L]).isMap)
				{
					if (AAsset(_assets[L]).isHero) _hero = HeroAsset(AAsset(_assets[L]));
				}
			}

			_gameArea.flatten();
			_container.addChildAt(_gameArea, 0);
			
			_background = new Background();
			_mainContainer.addChildAt(_background, 0);
			
			_actionManager = new ActionManager(_space, _hero);
			_actionManager.init();

			_isPaused = false;
		}

		public function update() : void
		{
			_container.x = -_hero.body.position.x + STAGE.stageWidth / 2;
			_container.y = -_hero.body.position.y + STAGE.stageHeight / 2;
			
			_background.setOffset( -_container.x, -_container.y );
			
			if (_isPaused) return;

			_space.step(1 / 60);

			const L : int = _assets.length;
			while ( --L != -1 )
			{
				var target : AAsset = AAsset(_assets[L]);

				if (target.toDelete)
				{
					_container.removeChild(target.body.graphic);
					_space.bodies.remove(target.body);
					target.clean();
				}
				if (!target.gonnaBeRemoved && !target.isMap && !target.isHero)
				{
					if (DisplayObject(_hero.body.graphic).bounds.intersects(DisplayObject(target.body.graphic).bounds))
					{
						if (target is CoinAsset)
						{
							_score += target.entity.value;
							target.showValue(_container);
							target.toRemove();
							
							dispatchEvent(new GameEvent(GameEvent.UPDATE));
						}
						
						if (target is EnemyAsset)
						{
							if(!_hero.hitted)
							{
								_score -= target.entity.value;
								target.showValue(_container);
								_score = _score < 0 ? 0 : _score;
								_hero.hit(_container);
								
								dispatchEvent(new GameEvent(GameEvent.UPDATE));
							}
						}
					}
				}
			}
		}

		private function _updateGraphicHero(b : Body) : void
		{
			if (_isPaused)
			{
				MovieClip(b.graphic).stop();
				return;
			}

			b.graphic.x = b.position.x;
			b.graphic.y = b.position.y;
			b.graphic.rotation = b.rotation;

			if (!(b.graphic is MovieClip)) return;

			if (b.angularVel > 5 || b.angularVel < -5)
			{
				MovieClip(b.graphic).play();
			} else {
				MovieClip(b.graphic).stop();
			}
		}
		
		private function _updateGraphic(b : Body) : void
		{
			if (_isPaused)
			{
				if ((b.graphic is MovieClip)) MovieClip(b.graphic).stop();
				return;
			}else{
				if ((b.graphic is MovieClip)) MovieClip(b.graphic).play();
			}

			b.graphic.x = b.position.x;
			b.graphic.y = b.position.y;
			b.graphic.rotation = b.rotation;
		}

		public function pause() : void
		{
			_isPaused = true;
		}

		public function reStart() : void
		{
			_isPaused = false;
		}

		public function clean() : void
		{
			_actionManager.clean();
			_gameArea.dispose();
			_background.dispose();
			_container.dispose();
			_mainContainer.dispose();
		}

		public function get mainContainer() : Sprite {
			return _mainContainer;
		}

		public function get score() : Number {
			return _score;
		}
	}
}
