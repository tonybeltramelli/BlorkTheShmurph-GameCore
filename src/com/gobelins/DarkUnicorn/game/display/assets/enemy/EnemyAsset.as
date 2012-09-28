package com.gobelins.DarkUnicorn.game.display.assets.enemy {
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;

	import starling.display.MovieClip;

	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.display.texture.SpriteSheet;
	import com.gobelins.DarkUnicorn.game.entities.EnemyEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class EnemyAsset extends AAsset implements IAsset {
		public function EnemyAsset(baseX : Number, baseY : Number, type : String)
		{
			super(new EnemyEntity(baseX, baseY));
			
			switch(type)
			{
				case EnemyType.GREEN_MONSTER :
					_entity.value = EnemyType.GREEN_MONSTER_VALUE;
				break;
				case EnemyType.GREY_MONSTER :
					_entity.value = EnemyType.GREY_MONSTER_VALUE;
				break;
				case EnemyType.RED_MONSTER :
					_entity.value = EnemyType.RED_MONSTER_VALUE;
				break;
			}
			
			_movieClip = new MovieClip(SpriteSheet.getAtlas().getTextures(type));
			
			_movieClip.pivotX = _movieClip.width/2;
			_movieClip.pivotY = _movieClip.height/2;
			
			_body = new Body(BodyType.STATIC);
			_body.graphic = _movieClip;
			
			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
		}
	}
}
