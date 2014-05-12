package
{
	import flash.display.BitmapData;
	
	[Embed(source="assets/textures/CustomEnemies.png")]
	dynamic public class CustomEnemies extends BitmapData
	{
	
		public function CustomEnemies(width:int = 1024, height:int = 1024)
		{
			super(width, height);
		}
	}
}