package
{
	import flash.display.BitmapData;
	
	[Embed(source="assets/textures/ActionTexture.png")]
	dynamic public class ActionTexture extends BitmapData
	{
	
		public function ActionTexture(width:int = 1024, height:int = 2048)
		{
			super(width, height);
		}
	}
}