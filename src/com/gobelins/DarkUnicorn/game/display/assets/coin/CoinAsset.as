package com.gobelins.DarkUnicorn.game.display.assets.coin {
	import nape.phys.Body;
	import nape.phys.BodyType;

	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.entities.CoinEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class CoinAsset extends AAsset implements IAsset {
		[Embed(source="../../../../../../../../medias/img/coinBitmapGold.png")]
		private var CoinBitmapGold : Class;
		
		[Embed(source="../../../../../../../../medias/img/coinBitmapSilver.png")]
		private var CoinBitmapSilver : Class;
		
		[Embed(source="../../../../../../../../medias/img/coinBitmapRed.png")]
		private var CoinBitmapRed : Class;
		
		public function CoinAsset(baseX : Number, baseY : Number, type : String)
		{
			super(new CoinEntity(baseX, baseY));
			
			var ClassBitmap : Class;
			
			switch(type)
			{
				case CoinType.GOLD :
					ClassBitmap = CoinBitmapGold;
					_value = CoinType.GOLD_VALUE;
				break;
				case CoinType.SILVER :
					ClassBitmap = CoinBitmapSilver;
					_value = CoinType.SILVER_VALUE;
				break;
				case CoinType.RED :
					ClassBitmap = CoinBitmapRed;
					_value = CoinType.RED_VALUE;
				break;
			}
			_bitmap = ClassBitmap;
			
			_sprite.pivotX = _sprite.width/2;
			_sprite.pivotY = _sprite.height/2;
			
			_body = new Body(BodyType.STATIC);
			_body.graphic = _sprite;

			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
		}
	}
}
