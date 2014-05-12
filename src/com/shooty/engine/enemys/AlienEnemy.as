package com.shooty.engine.enemys
{
	import com.pixi.PixiResourceManager;
	import com.pixi.SpriteFrameData;
	
	public class AlienEnemy extends Enemy
	{
		public static var enemyFrames:Vector.<SpriteFrameData>;

		public function AlienEnemy()
		{
			if(!enemyFrames)
			{
				enemyFrames = new Vector.<SpriteFrameData>();
				
				for (var i : int = 1; i < 40; i++) 
				{
					enemyFrames.push(PixiResourceManager.instance.spriteFrames["tendrilsOnly00"+i+ ".png"]);
				}
			}
			
			super(enemyFrames);
		}
	}
}