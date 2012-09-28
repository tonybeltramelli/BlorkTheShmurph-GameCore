package com.gobelins.DarkUnicorn.game.core.entity {
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AEntity {
		public var x : Number = 0;
		public var y : Number = 0;
		public var w : Number = 0;
		public var h : Number = 0;
		public var value : Number;
		//
		protected var _toMoveWithInteractions : Boolean = false;
		protected var _isMainCollider : Boolean = false;
		
		public function get toMoveWithInteractions() : Boolean {
			return _toMoveWithInteractions;
		}
		
		public function get isMainCollider() : Boolean {
			return _isMainCollider;
		}
	}
}