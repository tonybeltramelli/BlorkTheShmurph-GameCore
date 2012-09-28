package com.gobelins.DarkUnicorn.game.display.assets.coin {
	import nape.phys.Body;
	import nape.phys.BodyType;

	import starling.display.Image;

	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.display.texture.SpriteSheet;
	import com.gobelins.DarkUnicorn.game.entities.CoinEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class CoinAsset extends AAsset implements IAsset {
		
		public function CoinAsset(baseX : Number, baseY : Number, type : String)
		{
			super(new CoinEntity(baseX, baseY));
			
			switch(type)
			{
				case CoinType.GOLD :
					_entity.value = CoinType.GOLD_VALUE;
				break;
				case CoinType.SILVER :
					_entity.value = CoinType.SILVER_VALUE;
				break;
				case CoinType.BRONZE :
					_entity.value = CoinType.BRONZE_VALUE;
				break;
			}
			_image = new Image(SpriteSheet.getAtlas().getTexture(type));
			
			_image.pivotX = _image.width/2;
			_image.pivotY = _image.height/2;
			
			_body = new Body(BodyType.STATIC);
			_body.graphic = _image;
			
			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
		}
	}
}
