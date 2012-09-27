package com.gobelins.DarkUnicorn.core.engine {
	import com.gobelins.DarkUnicorn.core.display.element.AAsset;
	import com.gobelins.DarkUnicorn.core.action.manager.ActionManager;
	import com.gobelins.DarkUnicorn.core.engine.collision.RecordedCollision;
	import com.gobelins.DarkUnicorn.core.entity.EntityController;



	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class GameEngine {
		private var _actionManager : ActionManager;
		private var _entitiesControllers : Vector.<EntityController>;

		public function GameEngine(entitiesControllers : Vector.<EntityController>)
		{
			_entitiesControllers = entitiesControllers;
			_actionManager = new ActionManager();
			_actionManager.init();
		}

		public function update(mapCollisions : Vector.<RecordedCollision>, elementCollisions : Vector.<AAsset>) : void
		{
			var mapCollider : RecordedCollision = mapCollisions.length ? mapCollisions[0] : null;
			
			const L : int = _entitiesControllers.length;
			while ( --L != -1 )
			{
				if(_entitiesControllers[L].toCollide)
				{
					_entitiesControllers[L].compute(_actionManager.action, mapCollider);
				}
			}
			
			const N : int = elementCollisions.length;
			if(N > 10) return;
			while ( --N != -1 )
			{
				elementCollisions[N].entityController.remove();
			}
		}
		
		public function clean() : void
		{
			_actionManager.clean();
		}

	}
}
