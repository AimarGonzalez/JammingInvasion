package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	dynamic public class JunkyardLogo extends Sprite
	{
	
		[Embed(source="assets/textures/intro2.png")]
		private var bitm:Class;
		
		public function JunkyardLogo(){
			var b:Bitmap = new bitm();
			addChild(b);
		}
	}
}