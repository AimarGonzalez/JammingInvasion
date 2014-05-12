package com.shooty.engine.enemys 
{
	import com.pixi.PixiResourceManager;
	import com.pixi.SpriteFrameData;
	/**
	 * @author matgroves
	 */
	 
	public class Ball2Enemy extends Enemy
	{
		// only really need one set of frame data!
		public static var enemyFrames:Vector.<SpriteFrameData>;
		
		function Ball2Enemy()
		{
			// if enemy frames dont exist then create them all!
			if(!enemyFrames)
			{
				enemyFrames = new Vector.<SpriteFrameData>();
				
				enemyFrames.push(PixiResourceManager.instance.spriteFrames["invader_blue.png"]);
				//enemyFrames.push(PixiResourceManager.instance.spriteFrames["circle_blue.png"]);
			}
			
			super(enemyFrames);
		}
		
		
	}
}