package com.gobelins.DarkUnicorn.game.display.assets {
	import nape.phys.Body;
	import nape.phys.BodyType;

	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.entities.CoinEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class CoinAsset extends AAsset implements IAsset {
		[Embed(source="../../../../../../../medias/img/coinBitmap.png")]
		private var CoinBitmap : Class;

		public function CoinAsset(baseX : Number, baseY : Number)
		{
			super(new CoinEntity(baseX, baseY));

			_bitmap = CoinBitmap;
			
			_sprite.pivotX = _sprite.width/2;
			_sprite.pivotY = _sprite.height/2;
			
			_body = new Body(BodyType.STATIC);
			_body.graphic = _sprite;

			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
		}
	}
}
