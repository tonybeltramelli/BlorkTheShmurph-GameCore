package com.gobelins.DarkUnicorn.game.display.assets {
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;

	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.entities.HeroEntity;



	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class HeroAsset extends AAsset implements IAsset {
		
		[Embed(source="../../../../../../../medias/img/heroBitmap.png")]
		private var HeroBitmap:Class;
		
		public function HeroAsset()
		{			
			super(new HeroEntity());
			
			_bitmap = HeroBitmap;
			
			_sprite.pivotX = _sprite.width/2;
			_sprite.pivotY = _sprite.height/2;
			
			_body = new Body(BodyType.DYNAMIC, new Vec2(0, 0));
			_body.shapes.add((new Circle(_sprite.height/2, null, new Material(0.9))));
			_body.graphic = _sprite;
		}
	}
}
