package com.gobelins.DarkUnicorn.game {
	import starling.text.TextField;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.space.Space;

	import starling.display.Sprite;

	import com.gobelins.DarkUnicorn.game.core.action.manager.ActionManager;
	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.stage.STAGE;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Game {
		private var _assets : Vector.<IAsset>;
		private var _space : Space;
		private var _actionManager : ActionManager;
		private var _hero : AAsset;
		private var _score : Number;
		//
		private var _mainContainer : Sprite;
		private var _container : Sprite;
		private var _textField : TextField;

		public function Game(assets : Vector.<IAsset>)
		{
			_assets = assets;
			_space = new Space(new Vec2(0, 0));
			
			_mainContainer = new Sprite();
			
			_score = 0;
			
			_container = new Sprite();
			_mainContainer.addChild(_container);
			
			const L : int = assets.length;
			while ( --L != -1 )
			{
				var assetBody : Body = AAsset(_assets[L]).body;
				assetBody.space = _space;
				if (assetBody.graphic)
				{
					assetBody.graphicUpdate = updateGraphic;
					_container.addChild(assetBody.graphic);
				}

				if (AAsset(_assets[L]).isHero || AAsset(_assets[L]).isMap)
				{
					if (AAsset(_assets[L]).isHero) _hero = AAsset(_assets[L]);
				}
			}
			
			_textField = new TextField(200, 100, "Score :"+_score);
			_textField.color = 0xFF0000;
			_textField.fontSize = 24;
			_mainContainer.addChild(_textField);
			
			_actionManager = new ActionManager(_space);
			_actionManager.init();
		}

		public function update() : void
		{
			_space.step(1 / 60);

			_container.x = -_hero.body.position.x + STAGE.stageWidth / 2;
			_container.y = -_hero.body.position.y + STAGE.stageHeight / 2;

			const L : int = _assets.length;
			while ( --L != -1 )
			{
				if (AAsset(_assets[L]).toDelete)
				{
					_container.removeChild(AAsset(_assets[L]).body.graphic);
					_space.bodies.remove(AAsset(_assets[L]).body);
					AAsset(_assets[L]).clean();
				}
				if (!AAsset(_assets[L]).gonnaBeRemoved && !AAsset(_assets[L]).isMap && !AAsset(_assets[L]).isHero)
				{
					if (Sprite(_hero.body.graphic).bounds.intersects(Sprite(AAsset(_assets[L]).body.graphic).bounds))
					{
						_score ++;
						AAsset(_assets[L]).toRemove();
					}
				}
			}
			
			_textField.text = "Score :"+_score;
		}

		public function updateGraphic(b : Body) : void
		{
			b.graphic.x = b.position.x;
			b.graphic.y = b.position.y;
			b.graphic.rotation = b.rotation;
		}

		public function clean() : void
		{
			_actionManager.clean();
		}

		public function get mainContainer() : Sprite {
			return _mainContainer;
		}

		public function get score() : Number {
			return _score;
		}
	}
}
