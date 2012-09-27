package com.gobelins.DarkUnicorn.core.display {
	import com.gobelins.DarkUnicorn.core.display.element.AAsset;
	import com.gobelins.DarkUnicorn.core.display.element.IAsset;
	import com.gobelins.DarkUnicorn.core.engine.collision.CollisionList;
	import com.gobelins.DarkUnicorn.core.engine.collision.RecordedCollision;

	import flash.geom.Point;
	
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Renderer {
		private var _assets : Vector.<IAsset>;
		private var _collisionList : CollisionList;
		private var _hero : AAsset;
		
		public function Renderer(assets : Vector.<IAsset>)
		{
			_assets = assets;
			_collisionList = new CollisionList();
			
			const L : int = _assets.length;
			while ( --L != -1 )
			{
				if(AAsset(_assets[L]).isHero || AAsset(_assets[L]).isMap)
				{
					if(AAsset(_assets[L]).isHero) _hero = AAsset(_assets[L]);
					_collisionList.addItem(AAsset(_assets[L]));
				}
			}
		}
		
		public function render() : void
		{
			const N : int = _assets.length;
			while ( --N != -1 )
			{
				if(!(AAsset(_assets[N]).hidden)) _assets[N].render();
			}
		}
		
		public function clean() : void {
			const N : int = _assets.length;
			while ( --N != -1 ) _assets[N].clean();
		}

		public function get assets() : Vector.<IAsset> {
			return _assets;
		}

		public function get mapCollisions() : Vector.<RecordedCollision> {
			return _collisionList.checkCollisions();
		}
		
		public function get elementCollisions() : Vector.<AAsset>
		{
			var collisions : Vector.<AAsset> = new Vector.<AAsset>();
			
			const L : int = _assets.length;
			while ( --L != -1 )
			{
				if(!AAsset(_assets[L]).isMap && !AAsset(_assets[L]).isHero)
				{
					if(_hero.hitTestObject(AAsset(_assets[L]))) collisions.push(AAsset(_assets[L]));
				}
			}
			
			return collisions;
		}

		public function get heroPosition() : Point {
			return new Point(_hero.x, _hero.y);
		}
	}
}
