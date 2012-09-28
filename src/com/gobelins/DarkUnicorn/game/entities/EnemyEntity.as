package com.gobelins.DarkUnicorn.game.entities {
	import com.gobelins.DarkUnicorn.game.core.entity.AEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class EnemyEntity extends AEntity {
		public function EnemyEntity(baseX : Number, baseY : Number)
		{
			x = baseX;
			y = baseY;
		}
	}
}
