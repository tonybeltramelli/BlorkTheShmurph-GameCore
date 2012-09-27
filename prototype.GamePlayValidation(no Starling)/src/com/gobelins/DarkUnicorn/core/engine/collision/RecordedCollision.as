package com.gobelins.DarkUnicorn.core.engine.collision {
	import com.tonybeltramelli.lib.utils.math.UMath;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class RecordedCollision {
		private var _object1 : DisplayObject;
		private var _object2 : DisplayObject;
		private var _angle : Number;
		private var _overlapping : Vector.<Point>;
		private var _impact : Point;

		public function RecordedCollision(object1 : DisplayObject, object2 : DisplayObject, angle : Number, overlapping : Vector.<Point>)
		{
			_object1 = object1;
			_object2 = object2;
			_angle = angle;
			_overlapping = overlapping;
			
			const L : int = overlapping.length;
			
			var valuesX : Vector.<Number> = new Vector.<Number>(L, true);
			var valuesY : Vector.<Number> = new Vector.<Number>(L, true);
			
			while ( --L != -1 )
			{
				valuesX[L] = overlapping[L].x;
				valuesY[L] = overlapping[L].y;
			}
			
			_impact = new Point(UMath.average(valuesX), UMath.average(valuesY));
			valuesX = null;
			valuesY = null;
		}

		public function get object1() : DisplayObject {
			return _object1;
		}

		public function get object2() : DisplayObject {
			return _object2;
		}

		public function get angle() : Number {
			return _angle;
		}

		public function get overlapping() : Vector.<Point> {
			return _overlapping;
		}

		public function get impact() : Point {
			return _impact;
		}
	}
}
