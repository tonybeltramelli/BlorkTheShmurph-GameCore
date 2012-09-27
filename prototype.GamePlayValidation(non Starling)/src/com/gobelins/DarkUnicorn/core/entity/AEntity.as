package com.gobelins.DarkUnicorn.core.entity {
	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AEntity {
		public var toUpdate : Boolean = false;
		public var toHide : Boolean = false;
		public var speed : Number = 0;
		public var x : Number = 0;
		public var y : Number = 0;
		public var mass : Number = 0;
		public var angle : Number;
		public var impactX : Number;
		public var impactY: Number;
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