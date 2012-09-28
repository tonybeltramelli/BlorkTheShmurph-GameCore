package com.gobelins.DarkUnicorn.game.display {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.RenderTexture;

	import com.gobelins.DarkUnicorn.game.core.entity.AEntity;
	import com.gobelins.DarkUnicorn.game.display.texture.SpriteSheet;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class MapBuilder extends Sprite {
		private var _texture : RenderTexture;
		private var _img : Image;

		public function MapBuilder()
		{
			_fillBackground(1600, 1600);
		}

		private function _fillBackground(totalWidth : Number, totalHeight : Number) : void
		{
			var mapPattern : Image = new Image(SpriteSheet.getAtlas().getTexture("mapPattern"));
			var texture : RenderTexture = new RenderTexture(totalWidth, totalHeight);

			var lines : int = Math.round(totalWidth / mapPattern.width);
			var collums : int = Math.round(totalHeight / mapPattern.height);

			var i : int = 0;

			for (i = 0; i < lines; i++) {
				var j : int = 0;

				for (j = 0; j < collums; j++) {
					var img : Image = new Image(SpriteSheet.getAtlas().getTexture("mapPattern"));
					img.x = img.width * i;
					img.y = img.height * j;
					texture.draw(img);
					img = null;
				}
			}

			var pattern1 : Image = new Image(texture);
			var pattern2 : Image = new Image(texture);
			var pattern3 : Image = new Image(texture);
			var pattern4 : Image = new Image(texture);

			pattern1.x = -pattern1.width+1;
			pattern1.y = -pattern1.height-1;
			pattern2.x = -1;
			pattern2.y = -pattern1.height+1;
			pattern3.x = -pattern1.width+1;
			pattern3.y = -2;
			pattern4.x = -1;
			pattern4.y = -2;

			addChild(pattern1);
			addChild(pattern2);
			addChild(pattern3);
			addChild(pattern4);
			
			pattern1 = null;
			pattern2 = null;
			pattern3 = null;
			pattern4 = null;
			
			mapPattern = null;
			texture = null;
		}

		public function draw(entity : AEntity) : void
		{
			_texture = new RenderTexture(entity.w, entity.h);
			_texture.draw(_buildTexture(entity.w, entity.h));
			_img = new Image(_texture);
			_img.x = entity.x;
			_img.y = entity.y;

			addChild(_img);

			_texture = null;
			_img = null;
		}

		private function _buildTexture(totalWidth : Number, totalHeight : Number) : Sprite
		{
			var topLeft : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_topLeft"));
			var top : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_top"));
			var topRight : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_topRight"));
			var left : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_left"));
			var pattern1 : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_pattern"));
			var pattern2 : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_pattern"));
			var pattern3 : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_pattern"));
			var pattern4 : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_pattern"));
			var right : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_right"));
			var bottomLeft : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_bottomLeft"));
			var bottom : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_bottom"));
			var bottomRight : Image = new Image(SpriteSheet.getAtlas().getTexture("wall_bottomRight"));
			
			topLeft.x = 0;
			topLeft.y = 0;

			top.x = topLeft.width - 1;
			top.width = totalWidth - topLeft.width - topRight.width + 2;
			top.y = 0;

			topRight.x = top.x + top.width - 1;
			topRight.y = 0;

			left.x = 0;
			left.y = topLeft.y + topLeft.height - 2;
			left.height = totalHeight - topLeft.height - bottomLeft.height + 2;

			pattern1.x = topLeft.x + topLeft.width - 5;
			pattern1.y = topLeft.y + topLeft.height - 5;
			pattern1.width = top.width / 2 + 10;
			pattern1.height = left.height / 2 + 10;

			pattern2.x = pattern1.x + pattern1.width - 5;
			pattern2.y = topLeft.y + topLeft.height - 5;
			pattern2.width = top.width / 2 + 10;
			pattern2.height = left.height / 2 + 10;

			pattern3.x = topLeft.x + topLeft.width - 5;
			pattern3.y = pattern1.y + pattern1.height - 5;
			pattern3.width = top.width / 2 + 10;
			pattern3.height = left.height / 2 + 10;

			pattern4.x = pattern1.x + pattern1.width - 5;
			pattern4.y = pattern1.y + pattern1.height - 5;
			pattern4.width = top.width / 2 + 10;
			pattern4.height = left.height / 2 + 10;

			right.x = top.x + top.width;
			right.y = topRight.y + topRight.height - 2;
			right.height = left.height + 2;

			bottomLeft.x = 0;
			bottomLeft.y = left.y + left.height - 2;

			bottom.x = bottomLeft.x + bottomLeft.width - 1;
			bottom.y = bottomLeft.y;
			bottom.width = top.width + 2;

			bottomRight.x = bottom.x + bottom.width - 1;
			bottomRight.y = bottomLeft.y;

			var container : Sprite = new Sprite();
			container.addChild(topLeft);
			container.addChild(top);
			container.addChild(topRight);
			container.addChild(left);
			container.addChild(pattern1);
			container.addChild(pattern2);
			container.addChild(pattern3);
			container.addChild(pattern4);
			container.addChild(right);
			container.addChild(bottomLeft);
			container.addChild(bottom);
			container.addChild(bottomRight);
			
			topLeft = null;
			top = null;
			topRight = null;
			left = null;
			pattern1 = null;
			pattern2 = null;
			pattern3 = null;
			pattern4 = null;
			right = null;
			bottomLeft = null;
			bottom = null;
			bottomRight = null;

			return container;
		}
	}
}
