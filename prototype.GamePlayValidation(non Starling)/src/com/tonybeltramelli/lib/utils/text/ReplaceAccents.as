package com.tonybeltramelli.lib.utils.text {
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class ReplaceAccents
	{
		public static function noAccent(src : String) : String
		{
			src = src.replace(/[àáâãäå]/g, "a");
			src = src.replace(/[ÀÁÂÃÄÅ]/g, "A");
			src = src.replace(/[èéêë]/g, "e");
			src = src.replace(/[ËÉÊÈ]/g, "E");
			src = src.replace(/[ìíîï]/g, "i");
			src = src.replace(/[ÌÍÎÏ]/g, "I");
			src = src.replace(/[ðòóôõöø]/g, "o");
			src = src.replace(/[ÐÒÓÔÕÖØ]/g, "O");
			src = src.replace(/[ùúûü]/g, "u");
			src = src.replace(/[ÙÚÛÜ]/g, "U");
			src = src.replace(/[ýýÿ]/g, "y");
			src = src.replace(/[ÝÝŸ]/g, "Y");
			src = src.replace(/[ç]/g, "c");
			src = src.replace(/[Ç]/g, "C");
			src = src.replace(/[ñ]/g, "n");
			src = src.replace(/[Ñ]/g, "N");
			src = src.replace(/[š]/g, "s");
			src = src.replace(/[Š]/g, "S");
			src = src.replace(/[ž]/g, "z");
			src = src.replace(/[Ž]/g, "Z");
			src = src.replace(/[æ]/g, "ae");
			src = src.replace(/[Æ]/g, "AE");
			src = src.replace(/[œ]/g, "oe");
			src = src.replace(/[Œ]/g, "OE");

			return src;
		}
	}
}
