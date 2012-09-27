package com.gobelins.DarkUnicorn.display.assets {
	import com.gobelins.DarkUnicorn.core.display.element.AAsset;
	import com.gobelins.DarkUnicorn.core.display.element.IAsset;
	import com.gobelins.DarkUnicorn.entities.CoinEntity;
	import com.greensock.TweenLite;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class CoinAsset extends AAsset implements IAsset {
		public function CoinAsset(baseX : Number, baseY : Number)
		{
			super(new CoinEntity(baseX, baseY));
			
			graphics.beginFill(0x0000FF);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
			
		override public function render() : void
		{
			if(_entity.toHide)
			{
				_hide();
			}
			
			super.render();
		}
		
		override protected function _hide() : void
		{
			if(!_toHide)
			{
				_toHide = true;
				TweenLite.to(this, 0.3, {scaleX: 2, scaleY: 2, alpha: 0, onComplete: _toRemove});
			}
		}
		
		public function clean() : void
		{
		}
	}
}
