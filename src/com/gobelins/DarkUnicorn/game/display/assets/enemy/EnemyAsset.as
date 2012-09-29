package com.gobelins.DarkUnicorn.game.display.assets.enemy {
	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.entities.EnemyEntity;
	import com.gobelins.DarkUnicorn.game.medias.Medias;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import starling.display.Image;
	import starling.display.MovieClip;



	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class EnemyAsset extends AAsset implements IAsset {
		public function EnemyAsset(baseX : Number, baseY : Number, type : String)
		{
			super(new EnemyEntity(baseX, baseY));
			
			var valueImageName : String;
			
			switch(type)
			{
				case EnemyType.GREEN_MONSTER :
					_entity.value = EnemyType.GREEN_MONSTER_VALUE;
					valueImageName = EnemyType.GREEN_VALUE_NAME;
				break;
				case EnemyType.GREY_MONSTER :
					_entity.value = EnemyType.GREY_MONSTER_VALUE;
					valueImageName = EnemyType.GREY_VALUE_NAME;
				break;
				case EnemyType.RED_MONSTER :
					_entity.value = EnemyType.RED_MONSTER_VALUE;
					valueImageName = EnemyType.RED_VALUE_NAME;
				break;
			}
			
			_movieClip = new MovieClip(Medias.getAtlas().getTextures(type));
			
			_valueImage = new Image(Medias.getAtlas().getTexture(valueImageName));
			
			_movieClip.pivotX = _movieClip.width/2;
			_movieClip.pivotY = _movieClip.height/2;
			
			_body = new Body(BodyType.STATIC);
			_body.graphic = _movieClip;
			
			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
		}
	}
}
