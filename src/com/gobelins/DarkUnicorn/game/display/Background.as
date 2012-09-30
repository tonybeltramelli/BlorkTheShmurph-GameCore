package com.gobelins.DarkUnicorn.game.display
{
	import com.gobelins.DarkUnicorn.game.medias.Medias;
	import com.gobelins.DarkUnicorn.game.stage.STAGE;
	
	import flash.geom.Point;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	public class Background extends Sprite
	{
		private var image:Image;
		private var hRatio:Number = 1;
		private var vRatio:Number = 1;
		
		public function Background()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			var tex:Texture = Medias.getBg();
			image = new Image(tex);
			addChild(image);
			
			// ratio used to fix the texture size later in the the setOffset method
			hRatio = stage.stageWidth / image.width;
			vRatio = stage.stageHeight / image.height;
			
			// fill the whole stage with the background
			image.width = stage.stageWidth;
			image.height = stage.stageHeight;
			
			// if the background does not need alpha channel only
			image.blendMode = BlendMode.NONE;
			
			image.smoothing = TextureSmoothing.NONE;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		public function setOffset(xx:Number, yy:Number):void
		{
			/////////////////////////
			xx *= hRatio;
			yy *= vRatio;
			/////////////////////////
			yy = ((yy/image.height % 1)+1) ;
			xx = ((xx/image.width % 1)+1) ;
			
			//yy = (yy % 1)+1;
			//xx = (xx % 1)+1;
			
			image.setTexCoords(0, new Point(xx, yy));
			image.setTexCoords(1, new Point(xx+hRatio, yy ));
			image.setTexCoords(2, new Point(xx, yy + vRatio));
			image.setTexCoords(3, new Point(xx + hRatio, yy + vRatio));
		}
	}
}