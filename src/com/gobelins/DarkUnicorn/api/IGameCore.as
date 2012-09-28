package com.gobelins.DarkUnicorn.api {
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public interface IGameCore {
		function start() : void;

		function pause() : void;

		function restart() : void;

		function clean() : void;
	}
}
