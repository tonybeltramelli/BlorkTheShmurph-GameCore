package com.gobelins.DarkUnicorn.game.display.assets {
	import com.gobelins.DarkUnicorn.game.core.display.AAsset;
	import com.gobelins.DarkUnicorn.game.core.display.IAsset;
	import com.gobelins.DarkUnicorn.game.entities.MapEntity;

	import flash.display.BitmapData;

	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class MapAsset extends AAsset implements IAsset {
		public function MapAsset(baseX : Number, baseY : Number, baseWidth : Number, baseHeight : Number)
		{
			super(new MapEntity(baseX, baseY, baseWidth, baseHeight));

			_body = new Body(BodyType.STATIC);
			_body.shapes.add(new Polygon(Polygon.rect(0, 0, _entity.w, _entity.h)));
			var bitmapData : BitmapData = new BitmapData(_entity.w, _entity.h, false, 0x333333);
			var texture : Texture = Texture.fromBitmapData(bitmapData);
			_body.graphic = new Image(texture);

			_body.position.x = _entity.x;
			_body.position.y = _entity.y;
		}
	}
}
