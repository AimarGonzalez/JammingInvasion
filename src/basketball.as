package
{
	import flash.display.BitmapData;
	
	[Embed(source="assets/textures/basketball.png")]
	dynamic public class basketball extends BitmapData
	{
	
		public function basketball(width:int = 128, height:int = 128)
		{
			super(width, height);
		}
	}
}