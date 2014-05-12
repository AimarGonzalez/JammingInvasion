package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	dynamic public class WasteLogo extends Sprite
	{
	
		[Embed(source="assets/textures/intro1.png")]
		private var bitm:Class;
		 
		public function WasteLogo(){
			var b:Bitmap = new bitm();
			addChild(b);
		}
	}
}