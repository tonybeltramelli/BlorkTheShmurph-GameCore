package com.gobelins.DarkUnicorn.core.engine.collision {
	import flash.display.DisplayObject;

	public class CollisionList extends CollisionDetectionKit {
		public function CollisionList(objs : Vector.<DisplayObject> = null) : void
		{
			if(!objs) return;
			
			const L : int = objs.length;
			while ( --L != -1 )
			{
				addItem(objs[L]);				
			}
		}

		public function checkCollisions() : Vector.<RecordedCollision> {
			clearArrays();

			var NUM_OBJS : uint = _object.length;
			var item1 : DisplayObject = DisplayObject(_object[0]);
			var item2 : DisplayObject;
			for (var i : uint = 1; i < NUM_OBJS; i++) {
				item2 = DisplayObject(_object[i]);

				if (item1.hitTestObject(item2)) {
					if ((item2.width * item2.height) > (item1.width * item1.height)) {
						_objectCheck.push(new <DisplayObject>[item1, item2]);
					} else {
						_objectCheck.push(new <DisplayObject>[item2, item1]);
					}
				}
			}

			NUM_OBJS = _objectCheck.length;
			for (i = 0; i < NUM_OBJS; i++) {
				findCollisions(DisplayObject(_objectCheck[i][0]), DisplayObject(_objectCheck[i][1]));
			}

			return _objectCollision;
		}

		public function swapTarget(target : DisplayObject) : void {
			_object[0] = target;
		}

		public override function removeItem(obj : DisplayObject) : void {
			var loc : int = _object.indexOf(obj);
			if (loc > 0) {
				_object.splice(loc, 1);
			}
		}
	}
}