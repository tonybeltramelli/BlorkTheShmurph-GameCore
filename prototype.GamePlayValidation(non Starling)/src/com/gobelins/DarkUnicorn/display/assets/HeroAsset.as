package com.gobelins.DarkUnicorn.display.assets {
	import com.gobelins.DarkUnicorn.core.display.element.AAsset;
	import com.gobelins.DarkUnicorn.core.display.element.IAsset;
	import com.gobelins.DarkUnicorn.entities.HeroEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class HeroAsset extends AAsset implements IAsset {
		
		public function HeroAsset()
		{
			super(new HeroEntity());
			
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(0, 0, 20);
			graphics.endFill();
			
			graphics.lineStyle(1,0x000000);
			graphics.moveTo(-10, 5);
			graphics.lineTo(10, 5);
			
			graphics.beginFill(0x000000);
			graphics.drawCircle(10, -5, 2);
			graphics.drawCircle(-10, -5, 2);
			graphics.endFill();
		}
		
		public override function render() : void
		{
			rotation = _entity.angle;
				
			super.render();
		}
		
		public function clean() : void
		{
		}
	}
}
