package com.tonybeltramelli.lib.utils.geom {

	import com.tonybeltramelli.lib.utils.math.Converter;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Skew extends Sprite
	{
		private var _rectangle : Shape;
		private var _matrix : Matrix;

		public function Skew(rectangle : Shape, angle : Number)
		{
			_rectangle = rectangle;

			_matrix = _rectangle.transform.matrix;
			_matrix.c = Math.tan(Converter.deg2rad(angle));

			_rectangle.transform.matrix = _matrix;
		}

		public function get skewedRectangle() : Shape
		{
			return _rectangle;
		}
	}
}
