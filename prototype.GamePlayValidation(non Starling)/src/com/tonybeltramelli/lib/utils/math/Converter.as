package com.tonybeltramelli.lib.utils.math {
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Converter
	{
		public static function deg2rad(deg : Number) : Number
		{
			return deg * (Math.PI / 180);
		}

		public static function rad2deg(rad : Number) : Number
		{
			return (180 * rad) / Math.PI;
		}
		
		public static function min2millisecond(min : String) : Number
		{
			var a : Array = min.split(",");
			if(a.length > 1)
			{
				var f : Number = parseInt(a[0]);
				var s : Number = parseInt(a[1]);
				
				var fi : Number = f * 60;
				var mi : Number = (fi+s) * 1000;
				
				return mi;
			}else{
				return parseInt(a[0]) *60000;
			}
		}
		
		/*public static function getTime(millisecond : Number) : String
		{
			var sec : Number = millisecond / 1000;
			//var min : Number = sec / 60;
		}*/
	}
}
