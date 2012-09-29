package com.gobelins.DarkUnicorn.game.display.assets.coin {
	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.entities.CoinEntity;
	import com.gobelins.DarkUnicorn.game.medias.Medias;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import starling.display.Image;



	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class CoinAsset extends AAsset implements IAsset {
		
		public function CoinAsset(baseX : Number, baseY : Number, type : String)
		{
			super(new CoinEntity(baseX, baseY));
			
			var valueImageName : String;
			
			switch(type)
			{
				case CoinType.GOLD :
					_entity.value = CoinType.GOLD_VALUE;
					valueImageName = CoinType.GOLD_VALUE_NAME;
				break;
				case CoinType.SILVER :
					_entity.value = CoinType.SILVER_VALUE;
					valueImageName = CoinType.SILVER_VALUE_NAME;
				break;
				case CoinType.BRONZE :
					_entity.value = CoinType.BRONZE_VALUE;
					valueImageName = CoinType.BRONZE_VALUE_NAME;
				break;
			}
			
			_image = new Image(Medias.getAtlas().getTexture(type));
			
			_valueImage = new Image(Medias.getAtlas().getTexture(valueImageName));
			
			_image.pivotX = _image.width/2;
			_image.pivotY = _image.height/2;
			
			_body = new Body(BodyType.STATIC);
			_body.graphic = _image;
			
			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
			
			_sound = Medias.getSound(Medias.EarnCoinsSound);
		}

		override public function toRemove() : void
		{
			_sound.play();
			super.toRemove();
		}

	}
}
