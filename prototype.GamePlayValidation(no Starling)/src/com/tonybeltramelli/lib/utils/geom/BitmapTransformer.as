package com.tonybeltramelli.lib.utils.geom {

	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class BitmapTransformer
	{
		private var dataWidth : Number;
		private var dataHeight : Number;
		private var vertsArray : Array;
		private var newVertsArray : Array;
		private var hDiv : int;
		private var vDiv : int;
		//
		public var smoothOn : Boolean;

		public function BitmapTransformer(w : Number, h : Number, hdiv : int = 5, vdiv : int = 5)
		{
			this.dataWidth = w;
			this.dataHeight = h;
			this.hDiv = hdiv;
			this.vDiv = vdiv;
			this.vertsArray = [];
			this.newVertsArray = [];
			this.smoothOn = false;

			_setVertices();
		}

		private function _setVertices() : void
		{
			var j : int;
			var i : int;
			var hStep : Number = dataWidth / hDiv;
			var vStep : Number = dataHeight / vDiv;

			for (j = 0;j <= vDiv;j++) {
				vertsArray[j] = [];

				for (i = 0;i <= hDiv;i++) {
					vertsArray[j][i] = new Point(i * hStep, j * vStep);
				}
			}
		}

		private function _calcNewVerts(a : Point, b : Point, c : Point, d : Point) : void
		{
			var i : int;

			var j : int;

			var verVecLeft : Array = [d.x - a.x, d.y - a.y];

			var verVecRight : Array = [c.x - b.x, c.y - b.y];

			var curVert : Point;

			var curYCoeff : Number;

			var curXCoeff : Number;

			var curPointLeft : Point = new Point();

			var curPointRight : Point = new Point();

			var newVert : Point = new Point();

			for (j = 0;j <= vDiv;j++) {
				newVertsArray[j] = [];

				for (i = 0;i <= hDiv;i++) {
					newVertsArray[j][i] = new Point();

					curVert = vertsArray[j][i];

					curYCoeff = curVert.y / dataHeight;

					curXCoeff = curVert.x / dataWidth;

					curPointLeft.x = a.x + curYCoeff * verVecLeft[0];

					curPointLeft.y = a.y + curYCoeff * verVecLeft[1];

					curPointRight.x = b.x + curYCoeff * verVecRight[0];

					curPointRight.y = b.y + curYCoeff * verVecRight[1];

					newVert.x = curPointLeft.x + (curPointRight.x - curPointLeft.x) * curXCoeff;

					newVert.y = curPointLeft.y + (curPointRight.y - curPointLeft.y) * curXCoeff;

					newVertsArray[j][i].x = newVert.x;

					newVertsArray[j][i].y = newVert.y;
				}
			}
		}

		public function mapBitmapData(bd : BitmapData, topl : Point, topr : Point, botr : Point, botl : Point, cont : *) : void
		{
			var i : int;

			var j : int;

			var curVertOld0 : Point = new Point();

			var curVertNew0 : Point = new Point();

			var curVertOld1 : Point = new Point();

			var curVertNew1 : Point = new Point();

			var curVertOld2 : Point = new Point();

			var curVertNew2 : Point = new Point();

			var finMat : Matrix = new Matrix();

			var linMat : Matrix = new Matrix();

			_calcNewVerts(topl, topr, botr, botl);

			for (j = 0;j < vDiv;j++) {
				for (i = 0;i < hDiv;i++) {
					curVertOld0.x = vertsArray[j][i].x;

					curVertOld0.y = vertsArray[j][i].y;

					curVertOld1.x = vertsArray[j + 1][i].x;

					curVertOld1.y = vertsArray[j + 1][i].y;

					curVertOld2.x = vertsArray[j][i + 1].x;

					curVertOld2.y = vertsArray[j][i + 1].y;

					curVertNew0.x = newVertsArray[j][i].x;

					curVertNew0.y = newVertsArray[j][i].y;

					curVertNew1.x = newVertsArray[j + 1][i].x;

					curVertNew1.y = newVertsArray[j + 1][i].y;

					curVertNew2.x = newVertsArray[j][i + 1].x;

					curVertNew2.y = newVertsArray[j][i + 1].y;

					finMat.tx = curVertOld0.x;

					finMat.ty = curVertOld0.y;

					finMat.a = 0;

					finMat.b = (curVertOld1.y - curVertOld0.y) / dataWidth;

					finMat.c = (curVertOld2.x - curVertOld0.x) / dataHeight;

					finMat.d = 0;

					linMat.a = (curVertNew1.x - curVertNew0.x) / dataWidth;

					linMat.b = (curVertNew1.y - curVertNew0.y) / dataWidth;

					linMat.c = (curVertNew2.x - curVertNew0.x) / dataHeight;

					linMat.d = (curVertNew2.y - curVertNew0.y) / dataHeight;

					linMat.tx = curVertNew0.x;

					linMat.ty = curVertNew0.y;

					finMat.invert();

					finMat.concat(linMat);

					cont.graphics.beginBitmapFill(bd, finMat, false, smoothOn);

					cont.graphics.moveTo(curVertNew0.x, curVertNew0.y);

					cont.graphics.lineTo(curVertNew1.x, curVertNew1.y);

					cont.graphics.lineTo(curVertNew2.x, curVertNew2.y);

					cont.graphics.lineTo(curVertNew0.x, curVertNew0.y);

					cont.graphics.endFill();

					curVertOld0.x = vertsArray[j + 1][i + 1].x;

					curVertOld0.y = vertsArray[j + 1][i + 1].y;

					curVertOld1.x = vertsArray[j][i + 1].x;

					curVertOld1.y = vertsArray[j][i + 1].y;

					curVertOld2.x = vertsArray[j + 1][i].x;

					curVertOld2.y = vertsArray[j + 1][i].y;

					curVertNew0.x = newVertsArray[j + 1][i + 1].x;

					curVertNew0.y = newVertsArray[j + 1][i + 1].y;

					curVertNew1.x = newVertsArray[j][i + 1].x;

					curVertNew1.y = newVertsArray[j][i + 1].y;

					curVertNew2.x = newVertsArray[j + 1][i].x;

					curVertNew2.y = newVertsArray[j + 1][i].y;

					finMat.tx = curVertOld0.x;

					finMat.ty = curVertOld0.y;

					finMat.a = 0;

					finMat.b = (curVertOld1.y - curVertOld0.y) / dataWidth;

					finMat.c = (curVertOld2.x - curVertOld0.x) / dataHeight;

					finMat.d = 0;

					linMat.a = (curVertNew1.x - curVertNew0.x) / dataWidth;

					linMat.b = (curVertNew1.y - curVertNew0.y) / dataWidth;

					linMat.c = (curVertNew2.x - curVertNew0.x) / dataHeight;

					linMat.d = (curVertNew2.y - curVertNew0.y) / dataHeight;

					linMat.tx = curVertNew0.x;

					linMat.ty = curVertNew0.y;

					finMat.invert();

					finMat.concat(linMat);

					cont.graphics.beginBitmapFill(bd, finMat, false, smoothOn);

					cont.graphics.moveTo(curVertNew0.x, curVertNew0.y);

					cont.graphics.lineTo(curVertNew1.x, curVertNew1.y);

					cont.graphics.lineTo(curVertNew2.x, curVertNew2.y);

					cont.graphics.lineTo(curVertNew0.x, curVertNew0.y);

					cont.graphics.endFill();
				}
			}
		}
	}
}