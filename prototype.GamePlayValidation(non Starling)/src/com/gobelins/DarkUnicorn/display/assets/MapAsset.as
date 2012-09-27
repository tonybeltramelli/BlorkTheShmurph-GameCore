package com.gobelins.DarkUnicorn.display.assets {
	import com.gobelins.DarkUnicorn.core.display.element.AAsset;
	import com.gobelins.DarkUnicorn.core.display.element.IAsset;
	import com.gobelins.DarkUnicorn.entities.MapEntity;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class MapAsset extends AAsset implements IAsset {
		public function MapAsset()
		{
			super(new MapEntity());

			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(-219, -192, 68.1, 384.6);
			this.graphics.drawRect(140, -36, 78.1, 78.1);
			this.graphics.drawRect(244, -272, 44.05, 336.5);
			this.graphics.drawRect(413, -100, 188.3, 64.05);
			this.graphics.drawRect(361, 96, 32.05, 124.2);
			this.graphics.drawRect(537, 132, 256.35, 80.15);
			this.graphics.drawRect(218, 289, 292.45, 72.1);
			this.graphics.drawRect(-180, 362, 272.4, 72.1);
			this.graphics.drawRect(685, -437, 44.05, 336.5);
			this.graphics.drawRect(837, -148, 44.05, 336.5);
			this.graphics.drawRect(152, 366, 44.05, 336.5);
			this.graphics.drawRect(-337, 250, 154.6, 72.1);
			this.graphics.drawRect(-15, -552, 605.75, 72.1);
			this.graphics.drawRect(621, -736, 44.05, 336.5);
			this.graphics.drawRect(-104, -508, 44.05, 336.5);
			this.graphics.endFill();
		}

		public override function render() : void
		{
			super.render();
		}

		public function clean() : void
		{
		}
	}
}
