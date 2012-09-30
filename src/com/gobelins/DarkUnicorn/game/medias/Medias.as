package com.gobelins.DarkUnicorn.game.medias {
	import flash.display.Bitmap;
	import flash.media.Sound;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Medias {
		[Embed(source="../../../../../../medias/interface/background.jpg")]
		private static const _TextureBackground : Class;
		
		[Embed(source="../../../../../../medias/spriteSheet.png")]
		private static const _AtlasTextureGame : Class;
		
		private static var _atlasXmlGame : XML;
						
		// --- sounds --- //
		
		[Embed(source="../../../../../../medias/sounds/earnCoins.mp3")]
		public static const EarnCoinsSound : Class;
		
		[Embed(source="../../../../../../medias/sounds/endGame.mp3")]
		public static const EndGameSound : Class;
		
		[Embed(source="../../../../../../medias/sounds/loseCoins.mp3")]
		public static const LoseCoinsSound : Class;
		
		[Embed(source="../../../../../../medias/sounds/startGame.mp3")]
		public static const StartGameSound : Class;
		
		// --- particle --- //
		
		[Embed(source="../../../../../../medias/particle.pex", mimeType="application/octet-stream")]
		public static const ParticleConfig : Class;
		
		[Embed(source = "../../../../../../medias/texture.png")]
		public static const ParticleTexture : Class;
		
		private static var _bgTexture : Texture;
		private static var _gameTextureAtlas : TextureAtlas;
		
		public static function getBg() : Texture
		{
			if( !_bgTexture)
			{
				var bmp : Bitmap = Bitmap( new _TextureBackground() );
				_bgTexture = Texture.fromBitmap(bmp);
				_bgTexture.repeat = true;
			}
			
			return _bgTexture;
		}
		
		public static function getAtlas() : TextureAtlas
		{
			if (!_gameTextureAtlas)
			{
				var bitmap : Bitmap = Bitmap(new _AtlasTextureGame());
				var texture : Texture = Texture.fromBitmap(bitmap);
				
				_gameTextureAtlas = new TextureAtlas(texture, _getXMLAtlas());
			}

			return _gameTextureAtlas;
		}
		
		private static function _getXMLAtlas() : XML
		{
			if(_atlasXmlGame) return _atlasXmlGame;
			
			var atlasGameDescriptor : XML = <TextureAtlas/>;
			
			for each (var sub:Object in _AtlasGameDescriptor.all.sub)
			{
				atlasGameDescriptor.appendChild(<SubTexture name={sub.name} x={sub.x} y={sub.y} width={sub.width} height={sub.height}/>);
			}
			
			_atlasXmlGame = atlasGameDescriptor;
			return _atlasXmlGame;
		}

		public static function getSound(ClassName : Class) : Sound
		{
			var sound : Sound = Sound(new ClassName());
			return sound;
		}
		
		private static const _AtlasGameDescriptor : Object = {
			all:{sub:[
				{name:'coinBitmapBronze', x:44, y:364, width:36, height:32},
				{name:'coinBitmapGold', x:98, y:361, width:36, height:32},
				{name:'coinBitmapSilver', x:140, y:349, width:36, height:32}, 
				{name:'hero_01', x:2, y:362, width:40, height:40}, 
				{name:'hero_02', x:152, y:307, width:40, height:40}, 
				{name:'hero_03', x:110, y:296, width:40, height:40}, 
				{name:'hero_04', x:203, y:212, width:40, height:40}, 
				{name:'hero_05', x:204, y:170, width:40, height:40}, 
				{name:'hero_06', x:204, y:128, width:40, height:40}, 
				{name:'hero_07', x:204, y:128, width:40, height:40}, 
				{name:'hero_08', x:204, y:128, width:40, height:40}, 
				{name:'hero_09', x:204, y:128, width:40, height:40}, 
				{name:'hero_10', x:204, y:128, width:40, height:40}, 
				{name:'hero_11', x:204, y:86, width:40, height:40}, 
				{name:'hero_12', x:204, y:44, width:40, height:40}, 
				{name:'hero_13', x:204, y:2, width:40, height:40}, 
				{name:'hero_14', x:56, y:322, width:40, height:40}, 
				{name:'monster1-1', x:2, y:316, width:52, height:44}, 
				{name:'monster1_2', x:56, y:276, width:52, height:44}, 
				{name:'monster1_3', x:110, y:250, width:52, height:44}, 
				{name:'monster2_1', x:197, y:300, width:52, height:44}, 
				{name:'monster2_2', x:197, y:254, width:52, height:44}, 
				{name:'monster2_3', x:2, y:270, width:52, height:44}, 
				{name:'monster3_1', x:56, y:230, width:52, height:44},
				{name:'monster3_2', x:119, y:204, width:52, height:44}, 
				{name:'monster3_3', x:2, y:224, width:52, height:44}, 
				{name:'minusFive', x:173, y:204, width:28, height:20}, 
				{name:'minusOne', x:210, y:369, width:22, height:21}, 
				{name:'minusTen', x:194, y:346, width:39, height:21}, 
				{name:'plusFive', x:178, y:369, width:30, height:20}, 
				{name:'plusOne', x:173, y:226, width:23, height:21}, 
				{name:'plusTen', x:98, y:338, width:40, height:21}, 
				{name:'mapPattern', x:2, y:2, width:200, height:200}, 
				{name:'wall_bottom', x:61, y:204, width:56, height:24}, 
				{name:'wall_bottomLeft', x:207, y:392, width:21, height:24}, 
				{name:'wall_bottomRight', x:136, y:383, width:22, height:24}, 
				{name:'wall_left', x:184, y:391, width:21, height:56}, 
				{name:'wall_pattern', x:235, y:346, width:16, height:16}, 
				{name:'wall_right', x:173, y:249, width:22, height:56},
				{name:'wall_top', x:2, y:204, width:57, height:18}, 
				{name:'wall_topLeft', x:230, y:392, width:21, height:18}, 
				{name:'wall_topRight', x:160, y:391, width:22, height:18}
			]}
		};
	}
}
