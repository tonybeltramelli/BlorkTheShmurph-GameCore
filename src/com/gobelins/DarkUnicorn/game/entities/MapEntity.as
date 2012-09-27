package com.gobelins.DarkUnicorn.game.entities {
	import com.gobelins.DarkUnicorn.game.core.entity.AEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class MapEntity extends AEntity {
		public function MapEntity(baseX : Number, baseY : Number, baseWidth : Number, baseHeight : Number)
		{
			_isMainCollider = true;
			x = baseX;
			y = baseY;
			w = baseWidth;
			h = baseHeight;
		}
	}
}
