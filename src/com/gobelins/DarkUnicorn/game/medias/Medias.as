package com.gobelins.DarkUnicorn.game.medias {
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.display.Bitmap;
	import flash.media.Sound;

	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class Medias {
		[Embed(source="../../../../../../medias/spriteSheet.png")]
		private static const _AtlasTextureGame : Class;
		
		[Embed(source="../../../../../../medias/spriteSheetDescriptor.xml", mimeType="application/octet-stream")]
		private static const _AtlasXmlGame : Class;
		
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
		
		private static var _gameTextureAtlas : TextureAtlas;

		public static function getAtlas() : TextureAtlas
		{
			if (!_gameTextureAtlas)
			{
				var bitmap : Bitmap = Bitmap(new _AtlasTextureGame());
				var texture : Texture = Texture.fromBitmap(bitmap);
				var xml : XML = XML(new _AtlasXmlGame());

				_gameTextureAtlas = new TextureAtlas(texture, xml);
			}

			return _gameTextureAtlas;
		}

		public static function getSound(ClassName : Class) : Sound
		{
			var sound : Sound = Sound(new ClassName());
			return sound;
		}
	}
}
