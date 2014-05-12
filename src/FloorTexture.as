package
{
	import flash.display.BitmapData;
	
	[Embed(source="assets/textures/FloorTexture.png")]
	dynamic public class FloorTexture extends BitmapData
	{
	
		public function FloorTexture(width:int = 2048, height:int = 1024)
		{
			super(width, height);
		}
	}
}