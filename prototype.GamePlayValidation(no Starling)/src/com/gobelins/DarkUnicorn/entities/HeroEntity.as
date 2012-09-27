package com.gobelins.DarkUnicorn.entities {
	import com.gobelins.DarkUnicorn.core.entity.AEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class HeroEntity extends AEntity {
		public function HeroEntity()
		{
			y = 100;
			mass = 80;
			speed = 5;
			_toMoveWithInteractions = true;
		}
	}
}
