package com.gobelins.DarkUnicorn.core.engine.collision {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.errors.EOFError;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class CollisionDetectionKit {
		protected var _object : Vector.<DisplayObject>;
		protected var _objectCheck : Vector.<Vector.<DisplayObject>>;
		protected var _objectCollision : Vector.<RecordedCollision>;
		//
		private var _colorExclusion : Vector.<ColorCollisionDescripter>;
		private var _bmd1 : BitmapData;
		private var _bmd2 : BitmapData;
		private var _bmdResample : BitmapData;
		private var _pixels1 : ByteArray;
		private var _pixels2 : ByteArray;
		private var _rect1 : Rectangle;
		private var _transMatrix1 : Matrix;
		private var _transMatrix2 : Matrix;
		private var _colorTransform1 : ColorTransform;
		private var _colorTransform2 : ColorTransform;
		private var _item1Registration : Point;
		private var _item2Registration : Point;
		private var _alphaThreshold : Number;
		private var _returnAngle : Boolean;
		private var _returnAngleType : String;

		public function CollisionDetectionKit() : void {
			init();
		}

		private function init() : void {
			_objectCheck = new Vector.<Vector.<DisplayObject>>();
			_objectCollision = new Vector.<RecordedCollision>();
			_object = new Vector.<DisplayObject>();
			_colorExclusion = new Vector.<ColorCollisionDescripter>();

			_alphaThreshold = 0;
			_returnAngle = true;
			_returnAngleType = "RADIANS";
		}

		public function addItem(obj : DisplayObject) : void {
			_object.push(obj);
		}

		public function removeItem(obj : DisplayObject) : void {
			var loc : int = _object.indexOf(obj);
			if (loc > -1) {
				_object.splice(loc, 1);
			}
		}

		public function excludeColor(theColor : uint, alphaRange : uint = 255, redRange : uint = 20, greenRange : uint = 20, blueRange : uint = 20) : void {
			var numColors : int = _colorExclusion.length;
			for (var i : uint = 0; i < numColors; i++) {
				if (_colorExclusion[i].color == theColor) {
					break;
				}
			}

			var aPlus : uint, aMinus : uint, rPlus : uint, rMinus : uint, gPlus : uint, gMinus : uint, bPlus : uint, bMinus : uint;

			aPlus = (theColor >> 24 & 0xFF) + alphaRange;
			aMinus = aPlus - (alphaRange << 1);
			rPlus = (theColor >> 16 & 0xFF) + redRange;
			rMinus = rPlus - (redRange << 1);
			gPlus = (theColor >> 8 & 0xFF) + greenRange;
			gMinus = gPlus - (greenRange << 1);
			bPlus = (theColor & 0xFF) + blueRange;
			bMinus = bPlus - (blueRange << 1);

			var colorExclusion : Object = {color:theColor, aPlus:aPlus, aMinus:aMinus, rPlus:rPlus, rMinus:rMinus, gPlus:gPlus, gMinus:gMinus, bPlus:bPlus, bMinus:bMinus};
			_colorExclusion.push(colorExclusion);
		}

		public function removeExcludeColor(theColor : uint) : void {
			var found : Boolean = false, numColors : int = _colorExclusion.length;
			for (var i : uint = 0; i < numColors; i++) {
				if (_colorExclusion[i].color == theColor) {
					_colorExclusion.splice(i, 1);
					found = true;
					break;
				}
			}
		}

		protected function clearArrays() : void {
			_objectCheck = null;
			_objectCheck = new Vector.<Vector.<DisplayObject>>();

			_objectCollision = null;
			_objectCollision = new Vector.<RecordedCollision>();
		}

		protected function findCollisions(item1 : DisplayObject, item2 : DisplayObject) : void {
			var item1xDiff : Number, item1yDiff : Number;

			_colorTransform1 = item1.transform.colorTransform;
			_colorTransform2 = item2.transform.colorTransform;

			_item1Registration = new Point();
			_item2Registration = new Point();

			_item1Registration = item1.localToGlobal(_item1Registration);
			_item2Registration = item2.localToGlobal(_item2Registration);

			_bmd1 = new BitmapData(item1.width, item1.height, true, 0x00FFFFFF);
			_bmd2 = new BitmapData(item1.width, item1.height, true, 0x00FFFFFF);

			_transMatrix1 = item1.transform.matrix;

			var currentObj : DisplayObject = item1;
			while (currentObj.parent != null) {
				_transMatrix1.concat(currentObj.parent.transform.matrix);
				currentObj = currentObj.parent;
			}

			_rect1 = item1.getBounds(currentObj);
			if (item1 != currentObj) {
				_rect1.x += currentObj.x;
				_rect1.y += currentObj.y;
			}

			_transMatrix1.tx = item1xDiff = (_item1Registration.x - _rect1.left);
			_transMatrix1.ty = item1yDiff = (_item1Registration.y - _rect1.top);

			_transMatrix2 = item2.transform.matrix;

			currentObj = item2;
			while (currentObj.parent != null) {
				_transMatrix2.concat(currentObj.parent.transform.matrix);
				currentObj = currentObj.parent;
			}

			_transMatrix2.tx = (_item2Registration.x - _rect1.left);
			_transMatrix2.ty = (_item2Registration.y - _rect1.top);

			_bmd1.draw(item1, _transMatrix1, _colorTransform1, null, null, true);
			_bmd2.draw(item2, _transMatrix2, _colorTransform2, null, null, true);

			_pixels1 = _bmd1.getPixels(new Rectangle(0, 0, _bmd1.width, _bmd1.height));
			_pixels2 = _bmd2.getPixels(new Rectangle(0, 0, _bmd1.width, _bmd1.height));

			var k : uint = 0;
			var value1 : uint = 0;
			var value2 : uint = 0;
			var collisionPoint : Number = -1;
			var overlap : Boolean = false;
			var overlapping : Vector.<Point> = new Vector.<Point>();
			var locY : Number;
			var locX : Number;
			var locStage : Point;
			var hasColors : int = _colorExclusion.length;

			_pixels1.position = 0;
			_pixels2.position = 0;

			var pixelLength : int = _pixels1.length;
			while (k < pixelLength) {
				k = _pixels1.position;

				try {
					value1 = _pixels1.readUnsignedInt();
					value2 = _pixels2.readUnsignedInt();
				} catch(e : EOFError) {
					break;
				}

				var alpha1 : uint = value1 >> 24 & 0xFF, alpha2 : uint = value2 >> 24 & 0xFF;

				if (alpha1 > _alphaThreshold && alpha2 > _alphaThreshold) {
					var colorFlag : Boolean = false;
					if (hasColors) {
						var red1 : uint = value1 >> 16 & 0xFF, red2 : uint = value2 >> 16 & 0xFF, green1 : uint = value1 >> 8 & 0xFF, green2 : uint = value2 >> 8 & 0xFF, blue1 : uint = value1 & 0xFF, blue2 : uint = value2 & 0xFF;

						var colorObj : ColorCollisionDescripter;
						var item1Flags : uint;
						var item2Flags : uint;

						for (var n : uint = 0; n < hasColors; n++) {
							colorObj = ColorCollisionDescripter(_colorExclusion[n]);

							item1Flags = 0;
							item2Flags = 0;
							if ((blue1 >= colorObj.bMinus) && (blue1 <= colorObj.bPlus)) {
								item1Flags++;
							}
							if ((blue2 >= colorObj.bMinus) && (blue2 <= colorObj.bPlus)) {
								item2Flags++;
							}
							if ((green1 >= colorObj.gMinus) && (green1 <= colorObj.gPlus)) {
								item1Flags++;
							}
							if ((green2 >= colorObj.gMinus) && (green2 <= colorObj.gPlus)) {
								item2Flags++;
							}
							if ((red1 >= colorObj.rMinus) && (red1 <= colorObj.rPlus)) {
								item1Flags++;
							}
							if ((red2 >= colorObj.rMinus) && (red2 <= colorObj.rPlus)) {
								item2Flags++;
							}
							if ((alpha1 >= colorObj.aMinus) && (alpha1 <= colorObj.aPlus)) {
								item1Flags++;
							}
							if ((alpha2 >= colorObj.aMinus) && (alpha2 <= colorObj.aPlus)) {
								item2Flags++;
							}

							if ((item1Flags == 4) || (item2Flags == 4)) colorFlag = true;
						}
					}

					if (!colorFlag) {
						overlap = true;

						collisionPoint = k >> 2;
						
						locY = collisionPoint / _bmd1.width;
						locX = collisionPoint % _bmd1.width;

						locY -= item1yDiff;
						locX -= item1xDiff;

						locStage = item1.localToGlobal(new Point(locX, locY));
						overlapping.push(locStage);
					}
				}
			}

			if (overlap) {
				var angle : Number = _returnAngle ? findAngle(item1, item2) : 0;
				var recordedCollision : RecordedCollision = new RecordedCollision(item1, item2, angle, overlapping);
				_objectCollision.push(recordedCollision);
			}
		}

		private function findAngle(item1 : DisplayObject, item2 : DisplayObject) : Number {
			var center : Point = new Point((item1.width >> 1), (item1.height >> 1));
			var pixels : ByteArray = _pixels2;
			_transMatrix2.tx += center.x;
			_transMatrix2.ty += center.y;
			_bmdResample = new BitmapData(item1.width << 1, item1.height << 1, true, 0x00FFFFFF);
			_bmdResample.draw(item2, _transMatrix2, _colorTransform2, null, null, true);
			pixels = _bmdResample.getPixels(new Rectangle(0, 0, _bmdResample.width, _bmdResample.height));

			center.x = _bmdResample.width >> 1;
			center.y = _bmdResample.height >> 1;

			var columnHeight : uint = Math.round(_bmdResample.height);
			var rowWidth : uint = Math.round(_bmdResample.width);

			var pixel : uint, thisAlpha : uint, lastAlpha : int, edgeArray : Array = [], hasColors : int = _colorExclusion.length;

			for (var j : uint = 0; j < columnHeight; j++) {
				var k : uint = (j * rowWidth) << 2;
				pixels.position = k;
				lastAlpha = -1;
				var upperLimit : int = ((j + 1) * rowWidth) << 2;
				while (k < upperLimit) {
					k = pixels.position;

					try {
						pixel = pixels.readUnsignedInt();
					} catch(e : EOFError) {
						break;
					}

					thisAlpha = pixel >> 24 & 0xFF;

					if (lastAlpha == -1) {
						lastAlpha = thisAlpha;
					} else {
						if (thisAlpha > _alphaThreshold) {
							var colorFlag : Boolean = false;
							if (hasColors) {
								var red1 : uint = pixel >> 16 & 0xFF;
								var green1 : uint = pixel >> 8 & 0xFF;
								var blue1 : uint = pixel & 0xFF;

								var colorObj : ColorCollisionDescripter;
								var item1Flags : uint;

								for (var n : uint = 0; n < hasColors; n++) {
									colorObj = ColorCollisionDescripter(_colorExclusion[n]);

									item1Flags = 0;
									if ((blue1 >= colorObj.bMinus) && (blue1 <= colorObj.bPlus)) {
										item1Flags++;
									}
									if ((green1 >= colorObj.gMinus) && (green1 <= colorObj.gPlus)) {
										item1Flags++;
									}
									if ((red1 >= colorObj.rMinus) && (red1 <= colorObj.rPlus)) {
										item1Flags++;
									}
									if ((thisAlpha >= colorObj.aMinus) && (thisAlpha <= colorObj.aPlus)) {
										item1Flags++;
									}
									if (item1Flags == 4) {
										colorFlag = true;
									}
								}
							}

							if (!colorFlag) edgeArray.push(k >> 2);
						}
					}
				}
			}

			var edgePoint : int;
			var numEdges : int = edgeArray.length;
			var slopeYAvg : Number = 0;
			var slopeXAvg : Number = 0;
			for (j = 0; j < numEdges; j++) {
				edgePoint = int(edgeArray[j]);

				slopeYAvg += center.y - (edgePoint / rowWidth);
				slopeXAvg += (edgePoint % rowWidth) - center.x;
			}

			var average : Number = -Math.atan2(slopeYAvg, slopeXAvg);

			average = _returnAngleType == "RADIANS" ? average : average * 57.2957795;

			return average;
		}

		public function dispose() : void {
			_object = null;
			_object = new Vector.<DisplayObject>();
		}

		public function set alphaThreshold(theAlpha : Number) : void {
			if ((theAlpha <= 1) && (theAlpha >= 0)) {
				_alphaThreshold = theAlpha * 255;
			}
		}

		public function get alphaThreshold() : Number {
			return _alphaThreshold;
		}

		public function get returnAngle() : Boolean {
			return _returnAngle;
		}

		public function set returnAngle(value : Boolean) : void {
			_returnAngle = value;
		}

		public function set returnAngleType(returnType : String) : void {
			returnType = returnType.toUpperCase();

			switch (returnType) {
				case "DEGREES" :
				case "DEGREE" :
				case "DEG" :
				case "DEGS" :
					_returnAngleType = "DEGREES";
					break;
				case "RADIANS" :
				case "RADIAN" :
				case "RAD" :
				case "RADS" :
					_returnAngleType = "RADIANS";
					break;
				default :
					throw new Error("returnAngleType expects 'DEGREES' or 'RADIANS'");
					break;
			}
		}

		public function get returnAngleType() : String {
			return _returnAngleType;
		}

		public function get numChildren() : uint {
			return _object.length;
		}
	}
}